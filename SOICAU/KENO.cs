using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SOICAU
{
    public partial class KENO : Form
    {
        public KENO()
        {
            InitializeComponent();
        }
        public Dictionary<String, String> LastIDGet()
        {
            var data = SqlModule.GetDataTable("SELECT   periodCode  FROM SC.dbo.KENO group by periodCode");
            var result = new Dictionary<string, string>();
            foreach (DataRow item in data.Rows)
            {
                result.Add(item[0].ToString(), "");
            }
            return result;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var dt = SqlModule.GetDataTable("SELECT top  0 *  FROM SC.dbo.KENO");
            var url = "https://keno01.luckybest.vn:9105/lb/api/keno/statistic/last_result?num_his=10000000";
            var response = new WebClient().DownloadData(url);
            var htmlCode = Encoding.UTF8.GetString(response);
            dynamic data = JObject.Parse(htmlCode)["data"]["lstLastResult"];
            var LastID = LastIDGet();
            foreach (var item in data)
            {
                var row = dt.NewRow();

                row["periodCode"] = item["periodCode"];

                if (LastID.ContainsKey(row["periodCode"].ToString()))
                {
                    continue;
                }
                string periodTime = item["periodTime"] + "";
                //      periodTime = periodTime.Split(' ').FirstOrDefault();
                DateTime.TryParseExact(periodTime,
                                      "dd/MM/yyyy HH:mm:ss",
                                      CultureInfo.InvariantCulture,
                                      DateTimeStyles.None,
                                      out DateTime date);
                row["periodTime"] = date;

                row["numOver"] = item["numOver"];
                row["numUnder"] = item["numUnder"];
                row["numOdd"] = item["numOdd"];
                row["numEven"] = item["numEven"];
                int stt = 0;
                foreach (var it in item["arrResult"])
                {
                    stt++;
                    row["Num" + stt] = it;
                }
                dt.Rows.Add(row);
            }
            BulkCopy bk = new BulkCopy();
            bk.BulkInsertAll(dt, "dbo.KENO");
            MessageBox.Show("Update ok");
        }

        private void button2_Click(object sender, EventArgs e)
        {

            int lai = 0;
            int von = 0;
            var date = DateTime.Now;
            var dt = new DataTable();
            dt.Columns.Add("Date");
            dt.Columns.Add("TiLe");
            dt.Columns.Add("Total");
            dt.Columns.Add("Von");
            dt.Columns.Add("Lai");
            for (DateTime i = new DateTime(date.Year, date.Month, date.Day); i < date; i = i.AddMinutes(10))
            {
                var result = SqlModule.GetDataTable($"exec sp_TinhGiaiKENO  @date   ='{i.ToString("yyyy-MM-dd HH:mm:ss")}'");

                var OK = new List<string>();
                int total = result.Rows.Count;

                foreach (var item in result.Select(@"giai <> ''"))
                {
                    OK.Add(item["BT"].ToString());
                }
                var filteredDataTable = OK.Distinct().Count();

                List<ObjX> X2 = new List<ObjX>();
                List<int> AllNumber = new List<int>();
                foreach (DataRow item in result.Rows)
                {
                    AllNumber.Add(int.Parse(item["BT"].ToString()));
                }

                foreach (var item in AllNumber)
                {
                    foreach (var it in AllNumber.Where(z => z != item))
                    {
                        if (it > item)
                        {
                            X2.Add(new ObjX { X1 = item, X2 = it });
                        }
                        else
                        {
                            X2.Add(new ObjX { X1 = it, X2 = item });

                        }
                    }
                }
                var lo = X2.Select(z => z.X1 + " " + z.X2).Distinct().ToList();

                int MonthLai = 0;
                foreach (var item in lo)
                {
                    var x1 = item.Split(' ')[0];
                    var x2 = item.Split(' ')[1];
                    if (OK.Contains(x1) && OK.Contains(x2))
                    {
                        MonthLai += 14;
                    }
                }
                if (result.Rows.Count > 0)
                {
                    var row = dt.NewRow();
                    row["Date"] = i.ToString("dd/MM HH:mm");
                    row["TiLe"] = result.Rows[0]["Tile"].ToString();
                    row["Total"] = result.Rows[0]["OK"].ToString() + "/" + result.Rows[0]["Total"].ToString();
                    row["Von"] = lo.Count;
                    row["Lai"] = MonthLai - lo.Count;
                    dt.Rows.Add(row);
                }
                von += lo.Count;
                lai += MonthLai;

            }

            dataGridView1.DataSource = dt;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            button1_Click(sender, e);
            var date = DateTime.Now.AddMinutes(-DateTime.Now.Minute % 10).AddMinutes(10).ToString("yyyy-MM-dd HH:mm:00");

            var result = SqlModule.GetDataTable($"exec [sp_TinhGiaiKENO]  @date   ='{date}'");
            var OK = new List<string>();
            int total = result.Rows.Count;
            int lai = 0;
            int von = 0;
            #region Những số có về
            foreach (var item in result.Select(@"giai <> ''"))
            {
                OK.Add(item["BT"].ToString());
            }
            var filteredDataTable = OK.Distinct().Count();

            #endregion
            #region Tính chuỗi x2 cần đánh
            List<ObjX> X2 = new List<ObjX>();
            List<int> AllNumber = new List<int>();
            foreach (DataRow item in result.Rows)
            {
                AllNumber.Add(int.Parse(item["BT"].ToString()));
            }

            foreach (var item in AllNumber)
            {
                foreach (var it in AllNumber.Where(z => z != item))
                {
                    if (it > item)
                    {
                        X2.Add(new ObjX { X1 = item, X2 = it });
                    }
                    else
                    {
                        X2.Add(new ObjX { X1 = it, X2 = item });

                    }
                }
            }
            var lo = X2.Select(z => z.X1 + " " + z.X2).Distinct().ToList();

            von = lo.Count;
            #endregion

            #region tính lãi
            foreach (var item in lo)
            {
                var x1 = item.Split(' ')[0];
                var x2 = item.Split(' ')[1];
                if (OK.Contains(x1) && OK.Contains(x2))
                {
                    lai += 14;
                }
            }
            lai = lai - von;
            #endregion


            dataGridView1.DataSource = result;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            var date = DateTime.Now.AddMinutes(-DateTime.Now.Minute % 10).ToString("yyyy-MM-dd HH:mm:00");

            var result = SqlModule.GetDataTable($"exec [sp_TinhGiaiKENO]  @date   ='{date}'");
            var OK = new List<string>();
            int total = result.Rows.Count;
            int lai = 0;
            int von = 0;

            #region Những số có về
            foreach (var item in result.Select(@"giai <> ''"))
            {
                OK.Add(item["BT"].ToString());
            }
            var filteredDataTable = OK.Distinct().Count();

            #endregion
            #region Tính chuỗi x2 cần đánh
            List<ObjX> X2 = new List<ObjX>();
            List<int> AllNumber = new List<int>();
            foreach (DataRow item in result.Rows)
            {
                AllNumber.Add(int.Parse(item["BT"].ToString()));
            }

            foreach (var item in AllNumber)
            {
                foreach (var it in AllNumber.Where(z => z != item))
                {
                    if (it > item)
                    {
                        X2.Add(new ObjX { X1 = item, X2 = it });
                    }
                    else
                    {
                        X2.Add(new ObjX { X1 = it, X2 = item });

                    }
                }
            }
            var lo = X2.Select(z => z.X1 + " " + z.X2).Distinct().ToList();

            von = lo.Count;
            #endregion

            #region tính lãi
            foreach (var item in lo)
            {
                var x1 = item.Split(' ')[0];
                var x2 = item.Split(' ')[1];
                if (OK.Contains(x1) && OK.Contains(x2))
                {
                    lai += 14;
                }
            }
            lai = lai - von;
            #endregion


            dataGridView1.DataSource = result;
        }

        private void button3_Click(object sender, EventArgs e)
        {

            int lai = 0;
            int von = 0;
            var date = DateTime.Now;
            var dt = new DataTable();
            dt.Columns.Add("Date");
            dt.Columns.Add("TiLe");
            dt.Columns.Add("Total");
            dt.Columns.Add("Von");
            dt.Columns.Add("Lai");
            for (DateTime i = new DateTime(date.Year, date.Month, date.Day).AddDays(-1); i < date; i = i.AddMinutes(10))
            {
                var result = SqlModule.GetDataTable($"exec sp_TinhGiaiKENO  @date   ='{i.ToString("yyyy-MM-dd HH:mm:ss")}'");

                var OK = new List<string>();
                int total = result.Rows.Count;

                foreach (var item in result.Select(@"giai <> ''"))
                {
                    OK.Add(item["BT"].ToString());
                }
                var filteredDataTable = OK.Distinct().Count();

                List<ObjX> X2 = new List<ObjX>();
                List<int> AllNumber = new List<int>();
                foreach (DataRow item in result.Rows)
                {
                    AllNumber.Add(int.Parse(item["BT"].ToString()));
                }

                foreach (var item in AllNumber)
                {
                    foreach (var it in AllNumber.Where(z => z != item))
                    {
                        if (it > item)
                        {
                            X2.Add(new ObjX { X1 = item, X2 = it });
                        }
                        else
                        {
                            X2.Add(new ObjX { X1 = it, X2 = item });

                        }
                    }
                }
                var lo = X2.Select(z => z.X1 + " " + z.X2).Distinct().ToList();

                int MonthLai = 0;
                foreach (var item in lo)
                {
                    var x1 = item.Split(' ')[0];
                    var x2 = item.Split(' ')[1];
                    if (OK.Contains(x1) && OK.Contains(x2))
                    {
                        MonthLai += 14;
                    }
                }
                if (result.Rows.Count > 0)
                {
                    var row = dt.NewRow();
                    row["Date"] = i.ToString("dd/MM HH:mm");
                    row["TiLe"] = result.Rows[0]["Tile"].ToString();
                    row["Total"] = result.Rows[0]["OK"].ToString() + "/" + result.Rows[0]["Total"].ToString();
                    row["Von"] = lo.Count;
                    row["Lai"] = MonthLai - lo.Count;
                    dt.Rows.Add(row);
                }
                von += lo.Count;
                lai += MonthLai;

            }

            dataGridView1.DataSource = dt;
        }

        private void button4_Click(object sender, EventArgs e)
        {

            int lai = 0;
            int von = 0;
            var date = DateTime.Now;
            var dt = new DataTable();
            dt.Columns.Add("Date");
            dt.Columns.Add("TiLe");
            dt.Columns.Add("Total");
            dt.Columns.Add("Von");
            dt.Columns.Add("Lai");
            for (DateTime i = new DateTime(date.Year, date.Month, date.Day).AddDays(-2); i < date; i = i.AddMinutes(10))
            {
                var result = SqlModule.GetDataTable($"exec sp_TinhGiaiKENO  @date   ='{i.ToString("yyyy-MM-dd HH:mm:ss")}'");

                var OK = new List<string>();
                int total = result.Rows.Count;

                foreach (var item in result.Select(@"giai <> ''"))
                {
                    OK.Add(item["BT"].ToString());
                }
                var filteredDataTable = OK.Distinct().Count();

                List<ObjX> X2 = new List<ObjX>();
                List<int> AllNumber = new List<int>();
                foreach (DataRow item in result.Rows)
                {
                    AllNumber.Add(int.Parse(item["BT"].ToString()));
                }

                foreach (var item in AllNumber)
                {
                    foreach (var it in AllNumber.Where(z => z != item))
                    {
                        if (it > item)
                        {
                            X2.Add(new ObjX { X1 = item, X2 = it });
                        }
                        else
                        {
                            X2.Add(new ObjX { X1 = it, X2 = item });

                        }
                    }
                }
                var lo = X2.Select(z => z.X1 + " " + z.X2).Distinct().ToList();

                int MonthLai = 0;
                foreach (var item in lo)
                {
                    var x1 = item.Split(' ')[0];
                    var x2 = item.Split(' ')[1];
                    if (OK.Contains(x1) && OK.Contains(x2))
                    {
                        MonthLai += 14;
                    }
                }
                if (result.Rows.Count > 0)
                {
                    var row = dt.NewRow();
                    row["Date"] = i.ToString("dd/MM HH:mm");
                    row["TiLe"] = result.Rows[0]["Tile"].ToString();
                    row["Total"] = result.Rows[0]["OK"].ToString() + "/" + result.Rows[0]["Total"].ToString();
                    row["Von"] = lo.Count;
                    row["Lai"] = MonthLai - lo.Count;
                    dt.Rows.Add(row);
                }
                von += lo.Count;
                lai += MonthLai;

            }

            dataGridView1.DataSource = dt;
        }
    }
}

