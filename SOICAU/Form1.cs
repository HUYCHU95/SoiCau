using HtmlAgilityPack;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Excel.Functions.Text;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SOICAU
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //  readData();
            Type dgvType = dataGridView1.GetType();
            PropertyInfo pi = dgvType.GetProperty("DoubleBuffered",
                BindingFlags.Instance | BindingFlags.NonPublic);
            pi.SetValue(dataGridView1, true, null);
            comboBox1.SelectedIndex = 0;



        }
        public int GetTiLeThuong()
        {
            return int.Parse(inputTleThuong.Text);
        }

        ResultOfDay getKQ(string DATE, bool replace = false)
        {
            ResultOfDay row = new ResultOfDay();
            // SAMPLE https://xskt.com.vn/xsmb/ngay-8-11-2006
            var url = "https://xskt.com.vn/xsmb/ngay-" + DATE;
            var response = new WebClient().DownloadData(url);
            var htmlCode = Encoding.UTF8.GetString(response);

            string expr = "<tr>.*?<td>.*?</td>.*?<td>(.*?)</td>";
            Console.WriteLine("Expression: " + expr);
            MatchCollection mc = Regex.Matches(htmlCode, expr);
            foreach (Match m in mc)
            {
                string pattern = "<td.*?>(.*?)<\\/td>";
                var val = Regex.Matches(m.Value, pattern);
                var name = HtmlToPlainText(val[0].ToString());
                var valule = HtmlToPlainText(val[1].ToString());
                valule = valule.Replace("\r", " ");
                valule = valule.Replace("\n", " ");
                switch (name)
                {
                    case "ĐB": row.DB = valule; break;
                    case "G1": row.NHAT = valule; break;
                    case "G2": row.NHI = valule; break;
                    case "G3": row.BA = valule; break;
                    case "G4": row.TU = valule; break;
                    case "G5": row.NAM = valule; break;
                    case "G6": row.SAU = valule; break;
                    case "G7": row.BAY = valule; break;

                }

            }
            row.Date = DateTime.ParseExact(DATE, "dd-MM-yyyy", CultureInfo.InvariantCulture).ToString("yyyy-MM-dd");
            if (!string.IsNullOrEmpty(row.DB) || replace == true)
            {
                ResultOfDay.Insert(row);
            }
            return row;
        }
        private static string HtmlToPlainText(string html)
        {
            const string tagWhiteSpace = @"(>|$)(\W|\n|\r)+<";//matches one or more (white space or line breaks) between '>' and '<'
            const string stripFormatting = @"<[^>]*(>|$)";//match any character between '<' and '>', even when end tag is missing
            const string lineBreak = @"<(br|BR)\s{0,1}\/{0,1}>";//matches: <br>,<br/>,<br />,<BR>,<BR/>,<BR />
            var lineBreakRegex = new Regex(lineBreak, RegexOptions.Multiline);
            var stripFormattingRegex = new Regex(stripFormatting, RegexOptions.Multiline);
            var tagWhiteSpaceRegex = new Regex(tagWhiteSpace, RegexOptions.Multiline);

            var text = html;
            //Decode html specific characters
            text = System.Net.WebUtility.HtmlDecode(text);
            //Remove tag whitespace/line breaks
            text = tagWhiteSpaceRegex.Replace(text, "><");
            //Replace <br /> with line breaks
            text = lineBreakRegex.Replace(text, Environment.NewLine);
            //Strip formatting
            text = stripFormattingRegex.Replace(text, string.Empty);

            return text;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Task.Run(() =>
            {
                SqlModule.ExcuteCommand("delete ResultOfDay where db=''");
                var alldate = ResultOfDay.getAllDay();

                for (DateTime i = new DateTime(2023, 1, 1); i < DateTime.Now; i = i.AddDays(1))
                {
                    var date = i.ToString("dd-MM-yyyy");
                    this.Invoke(new Action(() => label1.Text = date));
                    if (alldate.Contains(i.ToString("yyyy-MM-dd")))
                    {
                        continue;
                    }
                    getKQ(date);

                }
                this.Invoke(new Action(() =>
                      button18_Click(sender, e)
                ));

            });
        }



        private void button5_Click_1(object sender, EventArgs e)
        {

            var result = SqlModule.GetDataTable($"exec sp_TinhLo  @date   ='{dateTimePicker1.Value.ToString("yyyy-MM-dd")}'");
            var text = "";
            foreach (DataRow item in result.Rows)
            {
                text += " " + item["BT"].ToString();
            }
            richTextBox1.Text = text;
            richTextBox1.Text += "\n" + ConvertTxtToDauThongKe(text);

            dataGridView1.DataSource = result;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            double tileVon = 27;
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");

            Task.Run(() =>
            {

                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    if (SqlModule.GetDataTable($"select Date from ResultOfDay where date='{i.ToString("yyyy-MM-dd")}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                    {
                        continue;
                    }
                    cau++;


                    this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd")));
                    var result = SqlModule.GetDataTable($"exec sp_TinhLo  @date   ='{i.ToString("yyyy-MM-dd")}'");

                    var OK = new List<int>();
                    int total = result.Rows.Count;

                    foreach (var item in result.Select(@"giai <> ''"))
                    {
                        OK.Add(int.Parse(item["BT"].ToString()));
                    }
                    var filteredDataTable = OK.Distinct().Count();

                    List<int> AllNumber = new List<int>();
                    foreach (DataRow item in result.Rows)
                    {
                        AllNumber.Add(int.Parse(item["BT"].ToString()));
                    }


                    var lo = AllNumber.Distinct().ToList();

                    var vonnow = tileVon * lo.Count;
                    double LaiNow = 0;
                    foreach (var item in AllNumber)
                    {
                        if (OK.Contains(item))
                        {
                            LaiNow += 99;
                        }
                    }

                    von += vonnow;
                    lai += LaiNow;


                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["cau"] = cau;
                            row["Date"] = i.ToString("yyyy-MM-dd");
                            row["Tổng số đánh"] = result.Rows[0]["Total"].ToString();
                            row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                            row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                            row["Tỉ lệ vốn"] = tileVon;
                            row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                            dt.Rows.Add(row);


                            row["Trúng"] = result.Select("giai <> ''").Count();

                            row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                            var db = SqlModule.GetDataTable($"SELECT bt FROM V_ResultOfDay WHERE DATE='{row["Date"]}' AND giai='DB'");
                            if (db.Rows.Count > 0 && OK.Contains(int.Parse(db.Rows[0][0].ToString())))
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();

                            }


                        }
                    }));







                }
                dt.DefaultView.Sort = "Date ASC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("ĐB <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });


        }


        private void button11_Click(object sender, EventArgs e)
        {
            #region Tính chuỗi x2 cần đánh
            List<ObjX> X2 = new List<ObjX>();
            var AllNumber = textBox1.Text.Split(' ').Where(z => !string.IsNullOrEmpty(z)).Select(z => int.Parse(z)).ToList();


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

            richTextBox1.Text = $"{lo.Count} Cặp x2 :\n" + string.Join(" ,\n", lo);
            #endregion
        }

        private void button13_Click(object sender, EventArgs e)
        {
            #region Tính chuỗi X4 cần đánh
            List<ObjX> X4 = new List<ObjX>();
            var AllNumber = textBox1.Text.Split(' ').Where(z => !string.IsNullOrEmpty(z)).Select(z => int.Parse(z)).ToList();


            foreach (var item in AllNumber)
            {
                foreach (var it in AllNumber.Where(z => z != item))
                {
                    foreach (var it2 in AllNumber.Where(z => z != item && z != it))
                    {
                        foreach (var it3 in AllNumber.Where(z => z != item && z != it && z != it2))
                        {
                            var temp = new List<int>() {
                        item,it,it2,it3
                        };
                            temp = temp.OrderBy(z => z).ToList();
                            X4.Add(new ObjX { X1 = temp[0], X2 = temp[1], X3 = temp[2], X4 = temp[3] });

                        }

                    }

                }
            }
            var lo = X4.Select(z => z.X1 + " " + z.X2 + " " + z.X3 + " " + z.X4).Distinct().ToList();

            richTextBox1.Text = $"{lo.Count} Cặp X4 :\n" + string.Join(" ,\n", lo);
            #endregion
        }

        private void button12_Click(object sender, EventArgs e)
        {
            #region Tính chuỗi x3 cần đánh
            List<ObjX> X3 = new List<ObjX>();
            var AllNumber = textBox1.Text.Split(' ').Where(z => !string.IsNullOrEmpty(z)).Select(z => int.Parse(z)).ToList();


            foreach (var item in AllNumber)
            {
                foreach (var it in AllNumber.Where(z => z != item))
                {
                    foreach (var it2 in AllNumber.Where(z => z != item && z != it))
                    {
                        var temp = new List<int>() {
                        item,it,it2
                        };
                        temp = temp.OrderBy(z => z).ToList();
                        X3.Add(new ObjX { X1 = temp[0], X2 = temp[1], X3 = temp[2] });

                    }

                }
            }
            var lo = X3.Select(z => z.X1 + " " + z.X2 + " " + z.X3).Distinct().ToList();

            richTextBox1.Text = $"{lo.Count} Cặp x3 :\n" + string.Join(" ,\n", lo);
            #endregion
        }


        private void button16_Click(object sender, EventArgs e)
        {
            Task.Run(() =>
            {
                var DT = new DataTable();
                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    this.Invoke(new Action(() => label1.Text = i.ToString()));

                    var result = SqlModule.GetDataTable($"exec [sp_TinhX2_DB]  @date   ='{i.ToString("yyyy-MM-dd")}'");
                    if (DT.Columns.Count == 0)
                    {
                        DT = result;
                    }
                    else
                    {
                        DT.Merge(result);
                    }

                }
                DT.DefaultView.Sort = "DATE DESC";

                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = DT;

                }));


            });


        }
        public int GetTileVonDefault()
        {
            int.TryParse(txtTileVon.Text, out int output);
            output = output == 0 ? 10 : output;
            return output;
        }

        private void button17_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            int lai = 0;
            int von = 0;
            int cau = 0;
            int TongLai = 0;
            var arrVaoVon = new int[] { 10, 20, 20, 30, 50, 70, 90 };
            var arrVaoVon2 = new int[] { 5, 10, 10, 15, 25, 35, 45 };
            int HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");

            Task.Run(() =>
            {

                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    if (SqlModule.GetDataTable($"select Date from ResultOfDay where date='{i.ToString("yyyy-MM-dd")}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                    {
                        continue;
                    }
                    var txtdate = i.ToString("yyyy-MM-dd");
                    this.Invoke(new Action(() => label1.Text = txtdate));

                    var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB  @date   ='{txtdate}'");
                    var OK = SqlModule.GetDataTable($"SELECT bt value FROM V_ResultOfDay WHERE DATE='{txtdate}' AND giai='DB'").FirstOrDefault().GetInt("value");


                    List<int> AllNumber = result.ToColumListInt("BT");

                    var vonnow = arrVaoVon[cau] * AllNumber.Count;

                    int LaiNow = 0;
                    int lastCau = cau;
                    if (AllNumber.Where(z => OK == z).Count() > 0)
                    {

                        LaiNow += GetTiLeThuong() * arrVaoVon[lastCau];
                        cau = 0;
                    }

                    von += vonnow;
                    lai += LaiNow;


                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["cau"] = cau;
                            row["Date"] = i.ToString("yyyy-MM-dd");
                            row["Tổng số đánh"] = AllNumber.Count;
                            row["Vốn"] = (arrVaoVon[lastCau] * AllNumber.Count * HeSo).ToString("#,###");
                            row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                            row["Tỉ lệ vốn"] = arrVaoVon[lastCau];
                            row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                            dt.Rows.Add(row);

                            row["Dàn Số"] = string.Join(" ", AllNumber);
                            row["ĐB"] = OK;
                            if (AllNumber.Contains(OK))
                            {
                                row["Trúng"] = "Có";
                            }

                        }
                    }));


                    cau++;

                    if (cau >= arrVaoVon.Length)
                    {
                        cau = 0;
                    }

                }
                dt.DefaultView.Sort = "Date ASC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
           
        }

        private void button18_Click(object sender, EventArgs e)
        {
            var from = dateTimePicker1.Value;
            var to = dateTimePicker2.Value;
            var data = SqlModule.GetDataTable($"SELECT * FROM  ResultOfDay where date between  '{  from.ToString("yyyy-MM-dd")}' and '{  to.ToString("yyyy-MM-dd")}'");
            dataGridView1.DataSource = data;
        }

        public static string toHTML_Table(DataTable dt)
        {
            if (dt.Rows.Count == 0) return ""; // enter code here

            StringBuilder builder = new StringBuilder();
            builder.Append("<html>");
            builder.Append("<head>");
            builder.Append("<title>");
            builder.Append("Page-");
            builder.Append(Guid.NewGuid());
            builder.Append("</title>");
            builder.Append("</head>");
            builder.Append("<body>");
            builder.Append("<table border='1px' cellpadding='5' cellspacing='0' ");
            builder.Append("style='border: solid 1px Silver; font-size: x-small;'>");
            builder.Append("<tr align='left' valign='top'>");

            foreach (DataColumn c in dt.Columns)
            {
                builder.Append("<td align='left' valign='top'><b>");
                builder.Append(c.ColumnName);
                builder.Append("</b></td>");
            }
            builder.Append("</tr>");
            foreach (DataRow r in dt.Rows)
            {
                builder.Append("<tr align='left' valign='top'>");
                foreach (DataColumn c in dt.Columns)
                {
                    builder.Append("<td align='left' valign='top'>");
                    builder.Append(r[c.ColumnName]);
                    builder.Append("</td>");
                }
                builder.Append("</tr>");
            }
            builder.Append("</table>");
            builder.Append("</body>");
            builder.Append("</html>");

            return builder.ToString();
        }
        private void timer1_Tick(object sender, EventArgs e)
        {
            try
            {
                label1.Text = "Timmer " + DateTime.Now.ToString("HH:mm:ss");
                if (SqlModule.GetDataTable("SELECT * FROM ResultOfDay WHERE DATE =CONVERT(DATE,GETDATE()) and DB!=''").Rows.Count == 0)
                {
                    button18_Click(sender, e);

                    if (SqlModule.GetDataTable("SELECT * FROM ResultOfDay WHERE DATE =CONVERT(DATE,GETDATE()) and DB!=''").Rows.Count > 0)
                    {
                        Task.Run(() =>
                        {
                            var kq = SqlModule.GetDataTable($@"DECLARE	@return_value int

                                                EXEC [dbo].[sp_TinhGiaiDB]
		                                                @DATE = '{DateTime.Now.ToString("yyyy-MM-dd")}'");





                            var HtmlKQ = "<h3>DB<h3/>" + toHTML_Table(kq);

                            SendMail.SendEmail(new string[] { "huychu.k14@gmail.com" }, "Luckky" + DateTime.Now.ToString("dd/MM/yyyy"), HtmlKQ + "<br>");
                        });
                    }
                }
            }
            catch (Exception)
            {

            }
        }

        private void button20_Click(object sender, EventArgs e)
        {
            timer1_Tick(sender, e);
            timer1.Start();
        }

        private void button21_Click(object sender, EventArgs e)
        {

            if (dataGridView1.Rows.Count > 0)
            {
                SaveFileDialog sfd = new SaveFileDialog();
                sfd.Filter = "CSV (*.csv)|*.csv";
                sfd.FileName = "Output.csv";
                bool fileError = false;
                if (sfd.ShowDialog() == DialogResult.OK)
                {
                    if (File.Exists(sfd.FileName))
                    {
                        try
                        {
                            File.Delete(sfd.FileName);
                        }
                        catch (IOException ex)
                        {
                            fileError = true;
                            MessageBox.Show("It wasn't possible to write the data to the disk." + ex.Message);
                        }
                    }
                    if (!fileError)
                    {
                        try
                        {
                            int columnCount = dataGridView1.Columns.Count;
                            string columnNames = "";
                            string[] outputCsv = new string[dataGridView1.Rows.Count + 1];
                            for (int i = 0; i < columnCount; i++)
                            {
                                columnNames += dataGridView1.Columns[i].HeaderText.ToString() + ",";
                            }
                            outputCsv[0] += columnNames;

                            for (int i = 1; (i - 1) < dataGridView1.Rows.Count; i++)
                            {
                                for (int j = 0; j < columnCount; j++)
                                {
                                    outputCsv[i] += (dataGridView1.Rows[i - 1].Cells[j].Value + "").Replace(",", ".") + ",";
                                }
                            }

                            File.WriteAllLines(sfd.FileName, outputCsv, Encoding.UTF8);
                            MessageBox.Show("Data Exported Successfully !!!", "Info");
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Error :" + ex.Message);
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("No Record To Export !!!", "Info");
            }
        }

        private void button22_Click(object sender, EventArgs e)
        {

            var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB  @date   ='{dateTimePicker1.Value.ToString("yyyy-MM-dd")}'");
            var text = "";
            foreach (DataRow item in result.Rows)
            {
                text += " " + item["BT"].ToString();
            }
            richTextBox1.Text = text;
            richTextBox1.Text += "\n" + ConvertTxtToDauThongKe(text);

            dataGridView1.DataSource = result;
        }

        public string ConvertTxtToDauThongKe(string text)
        {
            var input = text.Split(' ');
            string outPut = "";
            for (int i = 0; i <= 9; i++)
            {
                outPut += "\nĐầu " + i + " :";
                foreach (var item in input.Where(z => z != "" && z.Substring(0, 1) == i.ToString()))
                {
                    outPut += " " + item;
                }
            }
            return outPut;
        }

        private void button19_Click_1(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            var arrVaoVon = new double[] { 10, 15 };
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");
            List<int> AllNumber = new List<int>();
            Task.Run(() =>
            {

                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    var OK = new List<int>();
                    var LAST = new List<int>();

                    foreach (System.Data.DataRow item in SqlModule.GetDataTable(@" SELECT RIGHT(DB,2) bt   FROM [SC].[dbo].[ResultOfDay]  where    date ='" + i.ToString("yyyy-MM-dd") + "'").Rows)
                    {
                        OK.Add(int.Parse(item["BT"].ToString()));
                    }
                    //   foreach (System.Data.DataRow item in SqlModule.GetDataTable(@" SELECT bt   FROM [SC].[dbo].[v_ResultOfDay]  where    date ='" + i.AddDays(-1).ToString("yyyy-MM-dd") + "'").Rows)
                    //{
                    //    LAST.Add(int.Parse(item["BT"].ToString()));
                    //}

                    //AllNumber = AllNumber.Where(z => LAST.Contains(z)).ToList();
                    if (OK.Count == 0)
                    {
                        continue;
                    }

                    this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd")));



                    var filteredDataTable = OK.Distinct().Count();

                    if (AllNumber.Count == 0)
                    {

                        var result = SqlModule.GetDataTable($@" DECLARE @DATE date ='{i.ToString("yyyy-MM-dd")}'
                                        SELECT BT FROM[SC].[dbo].[V_ResultOfDay]    where
                                        date between  DATEADD(DAY, -100, @DATE)  and  DATEADD(DAY, -1, @DATE)     and giai in ('db')
                                        group by bt ");

                        foreach (DataRow itemx in result.Rows)
                        {
                            AllNumber.Add(int.Parse(itemx["BT"].ToString()));
                        }
                    }
                    int total = AllNumber.Count;


                    var lo = AllNumber.Distinct().ToList();
                    double tileVon = arrVaoVon[(int)cau];

                    var vonnow = tileVon * lo.Count;
                    double LaiNow = 0;
                    foreach (var item in AllNumber)
                    {
                        if (OK.Contains(item))
                        {
                             LaiNow = GetTiLeThuong() * tileVon;
                        }
                         
                    }

                    von += vonnow;
                    lai += LaiNow;

                    if (LaiNow!=0)
                    {
                        cau++;
                        if (cau >= arrVaoVon.Length)
                        {
                            cau = 0;
                        }
                    }
                    else
                    {
                        cau = 0;
                    }

                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {

                        var row = dt.NewRow();
                        row["cau"] = cau;
                        row["Date"] = i.ToString("yyyy-MM-dd");
                        row["Tổng số đánh"] = total;
                        row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                        row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                        row["Tỉ lệ vốn"] = tileVon;
                        row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                        dt.Rows.Add(row);


                        row["Dàn Số"] = string.Join(" ", AllNumber);

                        row["ĐB"] = string.Join("", OK);

                        int dbbt = OK.FirstOrDefault();
                        if (AllNumber.Contains(dbbt))
                        {

                            row["Trúng"] = "Có";
                        }



                    }));

                    foreach (var item in AllNumber)
                    {
                        if (OK.Contains(item))
                        {

                            var result = SqlModule.GetDataTable($@" DECLARE @DATE date ='{i.ToString("yyyy-MM-dd")}'
                                        SELECT BT FROM[SC].[dbo].[V_ResultOfDay]    where
                                        date between  DATEADD(DAY, -100, @DATE)  and  DATEADD(DAY, -1, @DATE)     and giai in ('db')
                                        group by bt ");
                            AllNumber = new List<int>();
                            foreach (DataRow itemx in result.Rows)
                            {
                                AllNumber.Add(int.Parse(itemx["BT"].ToString()));
                            }
                        }
                    }


                    tileVon = 10;

                }
                dt.DefaultView.Sort = "Date ASC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });

        }

        private void button26_Click(object sender, EventArgs e)
        {

            var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB_V2  @date   ='{dateTimePicker1.Value.ToString("yyyy-MM-dd")}'");
            var text = "";
            foreach (DataRow item in result.Rows)
            {
                text += " " + item["BT"].ToString();
            }
            richTextBox1.Text = text;
            richTextBox1.Text += "\n" + ConvertTxtToDauThongKe(text);
            dataGridView1.DataSource = result;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = textBox1.Text.Replace("-", " ");
            textBox1.Text = textBox1.Text.Replace(",", " ");
            textBox1.Text = textBox1.Text.Replace(";", " ");
            richTextBox1.Text = "\n" + ConvertTxtToDauThongKe(textBox1.Text);
        }



        private void button4_Click(object sender, EventArgs e)
        {
            var dtmonth = new DataTable();
            dtmonth.Columns.Add("Month");
            // dtmonth.Columns.Add("Vốn");
            dtmonth.Columns.Add("Vốn thực");
            dtmonth.Columns.Add("Lãi");
            //dtmonth.Columns.Add("Tổng lãi");
            dtmonth.Columns.Add("Số ngày trúng");

            Task.Run(() =>
            {
                for (DateTime date = DateTime.Now.AddYears(-2); date < DateTime.Now; date = date.AddMonths(1))
                {
                    double lai = 0;
                    double von = 0;
                    double TongLai = 0;
                    double tileVon = GetTileVonDefault();
                    double cau = 0;
                    double heso = 1000;

                    var dt = new DataTable();
                    dt.Columns.Add("Date");
                    dt.Columns.Add("ĐB");
                    dt.Columns.Add("Trúng");
                    dt.Columns.Add("Tổng số đánh");
                    dt.Columns.Add("Tỉ lệ vốn");
                    dt.Columns.Add("Vốn");
                    dt.Columns.Add("Lãi");
                    dt.Columns.Add("Tổng lãi");
                    dt.Columns.Add("Dàn Số");



                    for (DateTime i = new DateTime(date.Year, date.Month, 1); i.Month == date.Month; i = i.AddDays(1))
                    {
                        if (SqlModule.GetDataTable($"select Date from ResultOfDay where date='{i.ToString("yyyy-MM-dd")}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                        {
                            continue;
                        }

                        cau++;

                        this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd")));
                        var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB  @date   ='{i.ToString("yyyy-MM-dd")}'");

                        var OK = new List<int>();
                        int total = result.Rows.Count;

                        foreach (var item in result.Select(@"giai <> ''"))
                        {
                            OK.Add(int.Parse(item["BT"].ToString()));
                        }
                        var filteredDataTable = OK.Distinct().Count();

                        List<int> AllNumber = new List<int>();
                        foreach (DataRow item in result.Rows)
                        {
                            AllNumber.Add(int.Parse(item["BT"].ToString()));
                        }


                        var lo = AllNumber.Distinct().ToList();

                        var vonnow = tileVon * lo.Count;
                        double LaiNow = 0;
                        foreach (var item in AllNumber)
                        {
                            if (OK.Contains(item))
                            {
                                LaiNow = 99 * tileVon;
                                tileVon = tileVon = GetTileVonDefault();
                                cau = 0;
                            }
                        }
                        if (cau > 6)
                        {
                            tileVon = 0;

                            continue;
                        }
                        von += vonnow;
                        lai += LaiNow;


                        TongLai = TongLai - vonnow + LaiNow;
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["Date"] = i.ToString("yyyy-MM-dd");
                            row["Vốn"] = (vonnow * heso).ToString("#,###");
                            row["Lãi"] = (LaiNow * heso).ToString("#,###");
                            row["Tỉ lệ vốn"] = vonnow / int.Parse(result.Rows[0]["Total"].ToString());
                            row["Tổng lãi"] = (TongLai * heso).ToString("#,###");
                            dt.Rows.Add(row);

                            if (result.Select("giai <> ''").Count() > 0)
                            {
                                row["Trúng"] = "Có";
                                //row["ĐB"] = result.Select("giai <> ''").Select(z => z["BT"]).FirstOrDefault();
                            }
                            row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                            var db = SqlModule.GetDataTable($"SELECT BT FROM V_ResultOfDay WHERE DATE='{row["Date"]}' AND giai='DB'");
                            if (db.Rows.Count > 0)
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();

                            }

                        }
                        tileVon = tileVon * 1.5;


                    }

                    var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"]).ToString().Replace(",", ""))).Where(z => z < 0).ToList();
                    double vonthuc = 0;
                    if (listvonthuc.Count > 0)
                    {
                        vonthuc = listvonthuc.Min(z => z);
                    }

                    vonthuc = Math.Abs(vonthuc);
                    this.Invoke(new Action(() =>
                    {

                        TongLai = TongLai * heso;
                        lai = lai * heso;
                        von = von * heso;

                        var row = dtmonth.NewRow();
                        row["Month"] = date.ToString("yyyyMM");
                        row["Vốn thực"] = (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                        //row["Vốn"] = (von == 0 ? "0" : von.ToString("#,###")) + " vnd";
                        row["Lãi"] = (TongLai.ToString("#,###")) + " vnd";
                        //row["Tổng lãi"] = (TongLai).ToString("#,###");
                        row["Số ngày trúng"] = $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                        dtmonth.Rows.Add(row);

                        dataGridView1.DataSource = dtmonth;

                    }));



                }

            });
        }

        private void button7_Click(object sender, EventArgs e)
        {
            var dtmonth = new DataTable();
            dtmonth.Columns.Add("Month");
            dtmonth.Columns.Add("Trúng");
            dtmonth.Columns.Add("Tổng số đánh");
            dtmonth.Columns.Add("Tỉ lệ vốn");
            dtmonth.Columns.Add("Vốn");
            dtmonth.Columns.Add("Vốn thực");
            dtmonth.Columns.Add("Lãi");
            dtmonth.Columns.Add("Tổng lãi");
            dtmonth.Columns.Add("Số ngày trúng");

            Task.Run(() =>
            {
                for (DateTime date = DateTime.Now.AddYears(-2); date < DateTime.Now; date = date.AddMonths(1))
                {
                    double lai = 0;
                    double von = 0;
                    double TongLai = 0;
                    int tileVon = 1;

                    var dt = new DataTable();
                    dt.Columns.Add("Date");
                    dt.Columns.Add("ĐB");
                    dt.Columns.Add("Trúng");
                    dt.Columns.Add("Tổng số đánh");
                    dt.Columns.Add("Tỉ lệ vốn");
                    dt.Columns.Add("Vốn");
                    dt.Columns.Add("Lãi");
                    dt.Columns.Add("Tổng lãi");
                    dt.Columns.Add("Dàn Số");



                    for (DateTime i = new DateTime(date.Year, date.Month, 1); i.Month == date.Month; i = i.AddDays(1))
                    {
                        if (SqlModule.GetDataTable($"select Date from ResultOfDay where date='{i.ToString("yyyy-MM-dd")}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                        {
                            continue;
                        }

                        this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd")));
                        var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB_V2  @date   ='{i.ToString("yyyy-MM-dd")}'");

                        var OK = new List<int>();
                        int total = result.Rows.Count;

                        foreach (var item in result.Select(@"giai <> ''"))
                        {
                            OK.Add(int.Parse(item["BT"].ToString()));
                        }
                        var filteredDataTable = OK.Distinct().Count();

                        List<int> AllNumber = new List<int>();
                        foreach (DataRow item in result.Rows)
                        {
                            AllNumber.Add(int.Parse(item["BT"].ToString()));
                        }


                        var lo = AllNumber.Distinct().ToList();

                        var vonnow = tileVon * lo.Count;
                        double LaiNow = 0;
                        if (AllNumber.Where(z => OK.Contains(z)).Count() > 0)
                        {
                            LaiNow = (double)99 * tileVon;
                            if (LaiNow > 10000)
                            {
                                tileVon = 10;
                            }
                        }

                        von += vonnow;
                        lai += LaiNow;


                        TongLai = TongLai - vonnow + LaiNow;
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["Date"] = i.ToString("yyyy-MM-dd");
                            row["Tổng số đánh"] = result.Rows[0]["Total"].ToString();
                            row["Vốn"] = (vonnow * 10000).ToString("#,###");
                            row["Lãi"] = (LaiNow * 10000).ToString("#,###");
                            row["Tỉ lệ vốn"] = vonnow / int.Parse(result.Rows[0]["Total"].ToString());
                            row["Tổng lãi"] = (TongLai * 10000).ToString("#,###");
                            dt.Rows.Add(row);

                            if (result.Select("giai <> ''").Count() > 0)
                            {
                                row["Trúng"] = "Có";
                                //row["ĐB"] = result.Select("giai <> ''").Select(z => z["BT"]).FirstOrDefault();
                            }
                            row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                            var db = SqlModule.GetDataTable($"SELECT BT FROM V_ResultOfDay WHERE DATE='{row["Date"]}' AND giai='DB'");
                            if (db.Rows.Count > 0)
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();

                            }

                        }

                        tileVon = (int)(tileVon * 1.2);



                    }

                    var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"]).ToString().Replace(",", ""))).Where(z => z < 0).ToList();
                    double vonthuc = 0;
                    if (listvonthuc.Count > 0)
                    {
                        vonthuc = listvonthuc.Min(z => z);
                    }

                    vonthuc = Math.Abs(vonthuc);
                    this.Invoke(new Action(() =>
                    {

                        TongLai = TongLai * 10000;
                        lai = lai * 10000;
                        von = von * 10000;

                        var row = dtmonth.NewRow();
                        row["Month"] = date.ToString("yyyyMM");
                        row["Vốn thực"] = (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                        row["Vốn"] = (von == 0 ? "0" : von.ToString("#,###")) + " vnd";
                        row["Lãi"] = (TongLai.ToString("#,###")) + " vnd";
                        row["Tỉ lệ vốn"] = +Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0);
                        row["Tổng lãi"] = (TongLai).ToString("#,###");
                        row["Số ngày trúng"] = $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                        dtmonth.Rows.Add(row);

                        dataGridView1.DataSource = dtmonth;

                    }));



                }

            });
        }


        private void button14_Click(object sender, EventArgs e)
        {
            var data = SqlModule.GetDataTable("select tt FROM  V_ResultOfDay_TaiXiu  ORDER BY DATE DESC");
            var dt = new DataTable();
            string lastDT = "";
            int STT = 0;
            int rowcnt = 0;
            foreach (DataRow item in data.Rows)
            {
                var X = item[0].ToString();
                if (X != lastDT)
                {
                    STT++;
                    dt.Columns.Add(STT.ToString());
                    lastDT = X;
                    rowcnt = 0;
                }
                if (dt.Rows.Count <= rowcnt)
                {
                    var newrow = dt.NewRow();
                    dt.Rows.Add(newrow);
                }
                dt.Rows[rowcnt][STT.ToString()] = X;
                rowcnt++;
            }
            dataGridView1.DataSource = dt;
        }

        private void button15_Click(object sender, EventArgs e)
        {

        }

        private void button32_Click(object sender, EventArgs e)
        {
            string month = (sender as Button).Text;
            var year = comboBox1.Text;
            dateTimePicker1.Value = new DateTime(int.Parse(year), int.Parse(month), 1);
            dateTimePicker2.Value = new DateTime(int.Parse(year), int.Parse(month), 1).AddMonths(1).AddDays(-1);
            button17_Click(sender, e);
        }

        private void button35_Click(object sender, EventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                string fileName;

                fileName = dlg.FileName;
                //          SqlModule.ExcuteCommand("delete ResultOfDay2");
                UpdateMN(fileName);
                this.Text = ("ok");

                button36_Click(sender, e);
            }
        }
        void UpdateMN(string path)
        {
            string text = System.IO.File.ReadAllText(path);
            text = text.Replace("Kỳ", "|");
            var array = text.Split('|');
            var date = "";
            var result = new List<string>();
            foreach (var item in array)
            {
                if (item.Contains("res_date"))
                {
                    HtmlAgilityPack.HtmlDocument document = new HtmlAgilityPack.HtmlDocument();
                    document.LoadHtml(item);
                    foreach (HtmlNode node in document.DocumentNode.SelectNodes("//div[@class='res_date']"))
                    {
                        date = node.InnerText;
                        // etc...
                    }


                    date = date + "|" + document.DocumentNode.InnerText;
                    result.Add(date);

                }
            }
            List<DateTime> dateall = new List<DateTime>();
            foreach (DataRow it in SqlModule.GetDataTable("SELECT  [Date] FROM[SC].[dbo].[ResultOfDay2] ORDER BY DATE").Rows)
            {
                var txtdate = it[0].ToString();
                var i = DateTime.Parse(txtdate);
                dateall.Add(i);

            }
            foreach (var item in result)
            {
                ResultOfDay row = new ResultOfDay();
                var newtxtx = item.Replace(" -", "-");
                var mc = newtxtx.Split(' ');
                var txtdate = newtxtx.Split('|').FirstOrDefault();
                var i = DateTime.ParseExact(txtdate, "dd-MM HH:mm:ss", CultureInfo.InvariantCulture);
                i = new DateTime(i.Year, i.Month, i.Day, i.Hour, i.Minute, 0, 0);

                if (dateall.Contains(i))
                {
                    continue;
                }
                foreach (var m1 in mc)
                {
                    var m = m1.Replace("-", " ");

                    if (m.StartsWith("Biệt"))
                    {
                        row.DB = m.Replace("Biệt", "");
                    }
                    if (m.StartsWith("Nhất"))
                    {
                        row.NHAT = m.Replace("Nhất", "");
                    }
                    if (m.StartsWith("Nhì"))
                    {
                        row.NHI = m.Replace("Nhì", "");
                    }
                    if (m.StartsWith("Ba"))
                    {
                        row.BA = m.Replace("Ba", "");
                    }
                    if (m.StartsWith("Bốn"))
                    {
                        row.TU = m.Replace("Bốn", "");
                    }
                    if (m.StartsWith("Năm"))
                    {
                        row.NAM = m.Replace("Năm", "");
                    }
                    if (m.StartsWith("Sáu"))
                    {
                        row.SAU = m.Replace("Sáu", "");
                    }
                    if (m.StartsWith("Bảy"))
                    {
                        row.BAY = m.Replace("Bảy", "");
                    }
                    if (m.StartsWith("Tám"))
                    {
                        row.TAM = m.Replace("Tám", "");
                    }
                }
                row.Date = i.ToString("yyyy-MM-dd HH:mm");
                var sql = $@"INSERT INTO[dbo].[ResultOfDay2]
            ([Date]
          ,[DB]
          ,[NHAT]
          ,[NHI]
          ,[BA]
          ,[TU]
          ,[NAM]
          ,[SAU]
          ,[BAY]
          ,[TAM]
          )
         VALUES
           (
           '{row.Date}'
            , N'{row.DB}'
           ,N'{row.NHAT}'
           ,N'{row.NHI}'
           ,N'{row.BA}'
           ,N'{row.TU}'
           ,N'{row.NAM}'
           ,N'{row.SAU}'
           ,N'{row.BAY}'
           ,N'{row.TAM}'
           
            )";
                SqlModule.ExcuteCommand(sql);

            }
        }
        public static DataTable ConvertHTMLTablesToDataTable(string HTML)
        {


            DataTable dt = null;
            DataRow dr = null;
            DataColumn dc = null;
            string TableExpression = "<table[^>]*>(.*?)</table>";
            string HeaderExpression = "<th[^>]*>(.*?)</th>";
            string RowExpression = "<tr[^>]*>(.*?)</tr>";
            string ColumnExpression = "<td[^>]*>(.*?)</td>";
            bool HeadersExist = false;
            int iCurrentColumn = 0;
            int iCurrentRow = 0;

            // Get a match for all the tables in the HTML    
            MatchCollection Tables = Regex.Matches(HTML, TableExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase);

            // Loop through each table element    
            foreach (Match Table in Tables)
            {

                // Reset the current row counter and the header flag    
                iCurrentRow = 0;
                HeadersExist = false;

                // Add a new table to the DataSet    
                dt = new DataTable();

                // Create the relevant amount of columns for this table (use the headers if they exist, otherwise use default names)    
                if (Table.Value.Contains("<th"))
                {
                    // Set the HeadersExist flag    
                    HeadersExist = true;

                    // Get a match for all the rows in the table    
                    MatchCollection Headers = Regex.Matches(Table.Value, HeaderExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase);

                    // Loop through each header element    
                    foreach (Match Header in Headers)
                    {
                        //dt.Columns.Add(Header.Groups(1).ToString);  
                        dt.Columns.Add(Header.Groups[1].ToString());

                    }
                }
                else
                {
                    for (int iColumns = 1; iColumns <= Regex.Matches(Regex.Matches(Regex.Matches(Table.Value, TableExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase)[0].ToString(), RowExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase)[0].ToString(), ColumnExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase).Count; iColumns++)
                    {
                        dt.Columns.Add("Column " + iColumns);
                    }
                }

                // Get a match for all the rows in the table    
                MatchCollection Rows = Regex.Matches(Table.Value, RowExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase);

                // Loop through each row element    
                foreach (Match Row in Rows)
                {

                    // Only loop through the row if it isn't a header row    
                    if (!(iCurrentRow == 0 & HeadersExist == true))
                    {

                        // Create a new row and reset the current column counter    
                        dr = dt.NewRow();
                        iCurrentColumn = 0;

                        // Get a match for all the columns in the row    
                        MatchCollection Columns = Regex.Matches(Row.Value, ColumnExpression, RegexOptions.Multiline | RegexOptions.Singleline | RegexOptions.IgnoreCase);

                        // Loop through each column element    
                        foreach (Match Column in Columns)
                        {

                            DataColumnCollection columns = dt.Columns;

                            if (!columns.Contains("Column " + iCurrentColumn))
                            {
                                //Add Columns  
                                dt.Columns.Add("Column " + iCurrentColumn);
                            }
                            // Add the value to the DataRow    
                            var xxx = (Column.Groups[1].ToString());

                            dr[iCurrentColumn] = xxx;
                            // Increase the current column    
                            iCurrentColumn += 1;

                        }

                        // Add the DataRow to the DataTable    
                        dt.Rows.Add(dr);

                    }

                    // Increase the current row counter    
                    iCurrentRow += 1;
                }


            }

            return (dt);

        }


        void UpdateKeno5(string path)
        {
            string text = System.IO.File.ReadAllText(path);
            text = "<TABLE>" + text + "</TABLE>";
            var dt = ConvertHTMLTablesToDataTable(text);
            foreach (DataRow item in dt.Rows)
            {
                var Date = item[1].ToString().Replace("<br>", " ");
                DateTime time = DateTime.ParseExact(Date, "dd-MM HH:mm:ss", CultureInfo.InvariantCulture);

                var bt = item[2].ToString() + item[3] + item[4] + item[5] + item[6] + "";
                var sql = $@"INSERT INTO [dbo].[KENO5]
                           ([Date]
                           ,[BT])
                             VALUES
                           ('{time.ToString("yyyy-MM-dd HH:mm:ss")}'
                           ,'{bt}'
                            )";
                SqlModule.ExcuteCommand(sql);
            }
            MessageBox.Show("OK");
        }

        private void button39_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            double tileVon = 1;
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            int NG = 0;
            dt.Columns.Add("STT");
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");
            var arrVaoVon = new double[] { 0, 1, 1, 2, 2, 4, 4, 4, 8, 8, 12, 16 };
            arrVaoVon = new double[] { 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4 };
            arrVaoVon = new double[] { 1, 2, 4, 8, 1, 2, 4, 8, 1, 2, 4, 8, 1, 2, 4, 8, 1, 2, 4, 8, 1, 2, 4, 8, 16, 32, 64 };
            //   var arrVaoVon = new double[] { 0,1, 1, 1,1,1,1,1,2, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 7, 7, 7, 9, 9, 9, 11, 15, 20 };
            int STT = 0;
            Task.Run(() =>
            {

                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    var dateitem = SqlModule.GetDataTable($"select Date from ResultOfDay  where convert(date,date)='{i.ToString("yyyy-MM-dd")}' ORDER BY Date");

                    if (dateitem.Rows.Count == 0)
                    {
                        continue;
                    }
                    foreach (DataRow itemdate in dateitem.Rows)
                    {
                        STT++;

                        if (STT < 100)
                        {
                            continue;
                        }
                        var idate = DateTime.Parse(itemdate["Date"].ToString());
                        var txtdate = idate.ToString("yyyy-MM-dd HH:mm:ss");
                        this.Invoke(new Action(() => label1.Text = txtdate));
                        var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB_LO  @date   ='{txtdate}'");

                        var OK = new List<int>();
                        int total = result.Rows.Count;

                        foreach (var item in result.Select(@"giai <> ''"))
                        {
                            OK.Add(int.Parse(item["BT"].ToString()));
                        }
                        var filteredDataTable = OK.Distinct().Count();

                        List<int> AllNumber = new List<int>();
                        foreach (DataRow item in result.Rows)
                        {
                            AllNumber.Add(int.Parse(item["BT"].ToString()));
                        }

                        tileVon = arrVaoVon[(int)cau];
                        if (999999 == NG)
                        {
                            tileVon = 0;
                        }

                        var lo = AllNumber.Distinct().ToList();

                        var vonnow = tileVon * lo.Count * 27;
                        double LaiNow = result.Select("giai <> ''").Count() * 99 * tileVon;
                        int sotrung = result.Select("giai <> ''").Select(z => z["BT"]).Distinct().Count();


                        //if (sotrung==2)
                        //{
                        //    LaiNow +=  tileVon * 17;
                        //} 
                        //if (sotrung==3)
                        //{
                        //    LaiNow += tileVon * 17*2;
                        //     LaiNow += tileVon * 74;
                        //} 
                        //if (sotrung==4)
                        //{
                        //    LaiNow += tileVon * 17*6;
                        //    LaiNow += tileVon * 74*4;
                        //    LaiNow += tileVon * 251;
                        //}

                        von += vonnow;
                        lai += LaiNow;

                        TongLai = TongLai - vonnow + LaiNow;

                        this.Invoke(new Action(() =>
                        {
                            if (result.Rows.Count > 0)
                            {
                                var row = dt.NewRow();
                                row["STT"] = STT;
                                row["cau"] = cau;
                                row["Date"] = txtdate;
                                row["Tổng số đánh"] = result.Rows.Count;
                                row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                                row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                                row["Tỉ lệ vốn"] = tileVon;
                                row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                                dt.Rows.Add(row);

                                if (result.Select("giai <> ''").Count() > 0)
                                {
                                    row["Trúng"] = string.Join(",", result.Select("giai <> ''").Select(z => z["BT"]));
                                }
                                row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                                var db = SqlModule.GetDataTable($"SELECT value FROM V_ResultOfDay  WHERE DATE='{row["Date"]}' AND giai='DB'");
                                if (db.Rows.Count > 0)
                                {
                                    row["ĐB"] = db.Rows[0][0].ToString();

                                }

                            }
                        }));



                        if (result.Select("giai <> ''").Count() == 0 || vonnow >= LaiNow)
                        {


                            cau++;

                        }
                        else
                        {

                            cau = 0;


                            NG = 0;
                        }
                        if (cau >= arrVaoVon.Length)
                        {
                            cau = 0;
                            NG = 999999;
                        }


                    }
                }
                dt.DefaultView.Sort = "Date desc";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });

        }

        private void button8_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            var arrVaoVon = new double[] { 1, 1, 2, 3, 5, 7, 11, 15, 20 };
            double tileVon = arrVaoVon[0];
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");

            Task.Run(() =>
            {

                for (DateTime i = dateTimePicker1.Value.Date; i <= dateTimePicker2.Value.Date; i = i.AddDays(1))
                {
                    if (SqlModule.GetDataTable($"select Date from ResultOfDay where date='{i.ToString("yyyy-MM-dd")}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                    {
                        continue;
                    }
                    cau++;


                    this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd")));
                    var result = SqlModule.GetDataTable($"exec sp_TinhGiaiDB_X3  @date   ='{i.ToString("yyyy-MM-dd")}'");

                    var OK = new List<int>();
                    int total = result.Rows.Count;

                    foreach (var item in result.Select(@"giai <> ''"))
                    {
                        OK.Add(int.Parse(item["BT"].ToString()));
                    }
                    var filteredDataTable = OK.Distinct().Count();

                    List<int> AllNumber = new List<int>();
                    foreach (DataRow item in result.Rows)
                    {
                        AllNumber.Add(int.Parse(item["BT"].ToString()));
                    }


                    var lo = AllNumber.Distinct().ToList();

                    var vonnow = tileVon * lo.Count;
                    double LaiNow = 0;
                    foreach (var item in AllNumber)
                    {
                        if (OK.Contains(item))
                        {
                            LaiNow = 99 * tileVon;
                            if (TongLai < 0)
                            {
                                //        tileVon = tileVon * 2;
                            }
                            cau = 0;
                        }
                    }

                    von += vonnow;
                    lai += LaiNow;


                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["cau"] = cau;
                            row["Date"] = i.ToString("yyyy-MM-dd");
                            row["Tổng số đánh"] = result.Rows[0]["Total"].ToString();
                            row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                            row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                            row["Tỉ lệ vốn"] = vonnow / int.Parse(result.Rows[0]["Total"].ToString());
                            row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                            dt.Rows.Add(row);

                            if (result.Select("giai <> ''").Count() > 0)
                            {
                                row["Trúng"] = "Có";
                                //row["ĐB"] = result.Select("giai <> ''").Select(z => z["BT"]).FirstOrDefault();
                            }
                            row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                            var db = SqlModule.GetDataTable($"SELECT value FROM V_ResultOfDay WHERE DATE='{row["Date"]}' AND giai='DB'");
                            if (db.Rows.Count > 0)
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();

                            }

                        }
                    }));





                    if (cau >= arrVaoVon.Count())
                    {
                        tileVon = 0;

                        continue;
                    }
                    tileVon = arrVaoVon[(int)cau];
                }
                dt.DefaultView.Sort = "Date ASC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });
        }

        private void button9_Click(object sender, EventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                string fileName;

                fileName = dlg.FileName;
                SqlModule.ExcuteCommand("delete KENO5");
                UpdateKeno5(fileName);
                this.Text = ("ok");

                // button36_Click(sender, e);
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            var arrVaoVon = new double[] { 10, 20, 40, 80, 100 };
            double tileVon = arrVaoVon[0];
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");

            Task.Run(() =>
            {

                foreach (DataRow it in SqlModule.GetDataTable("SELECT  [Date] FROM[SC].[dbo].[KENO5] ORDER BY DATE").Rows)
                {
                    var txtdate = it[0].ToString();
                    var i = DateTime.Parse(txtdate);
                    cau++;


                    this.Invoke(new Action(() => label1.Text = i.ToString("yyyy-MM-dd HH:mm:ss")));
                    var result = SqlModule.GetDataTable($"exec sp_TinhGiai_Keno  @date   ='{i.ToString("yyyy-MM-dd HH:mm:ss")}'");

                    var OK = new List<int>();
                    int total = result.Rows.Count;

                    foreach (var item in result.Select(@"giai <> ''"))
                    {
                        OK.Add(int.Parse(item["BT"].ToString()));
                    }
                    var filteredDataTable = OK.Distinct().Count();

                    List<int> AllNumber = new List<int>();
                    foreach (DataRow item in result.Rows)
                    {
                        AllNumber.Add(int.Parse(item["BT"].ToString()));
                    }


                    var lo = AllNumber.Distinct().ToList();

                    var vonnow = tileVon * lo.Count;
                    double LaiNow = 0;
                    foreach (var item in AllNumber)
                    {
                        if (OK.Contains(item))
                        {
                            LaiNow = 9.8 * tileVon * result.Select("giai <> ''").Count();
                            if (TongLai < 0)
                            {
                                //        tileVon = tileVon * 2;
                            }
                            cau = 0;
                        }
                    }

                    von += vonnow;
                    lai += LaiNow;


                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["cau"] = cau;
                            row["Date"] = i.ToString("yyyy-MM-dd HH:mm:ss");
                            row["Tổng số đánh"] = result.Rows.Count;
                            row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                            row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                            row["Tỉ lệ vốn"] = tileVon;
                            row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                            dt.Rows.Add(row);

                            if (result.Select("giai <> ''").Count() > 0)
                            {
                                row["Trúng"] = result.Select("giai <> ''").Count();
                            }
                            row["Dàn Số"] = string.Join(" ", result.AsEnumerable().Select(z => z["BT"]));
                            var db = SqlModule.GetDataTable($"SELECT BT FROM [KENO5] WHERE DATE='{row["Date"]}'  ");
                            if (db.Rows.Count > 0)
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();

                            }

                        }
                    }));





                    if (cau >= arrVaoVon.Count())
                    {
                        tileVon = 0;

                        continue;
                    }
                    tileVon = arrVaoVon[(int)cau];
                }
                dt.DefaultView.Sort = "Date ASC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });
        }

        private void button36_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = $"";
            double lai = 0;
            double von = 0;
            double cau = 0;
            double TongLai = 0;
            double tileVon = GetTileVonDefault();
            double HeSo = 1000;
            var date = dateTimePicker1.Value;
            var dt = new DataTable();
            dt.Columns.Add("cau");
            dt.Columns.Add("Date");
            dt.Columns.Add("ĐB");
            dt.Columns.Add("Trúng");
            dt.Columns.Add("Tổng số đánh");
            dt.Columns.Add("Tỉ lệ vốn");
            dt.Columns.Add("Vốn");
            dt.Columns.Add("Lãi");
            dt.Columns.Add("Tổng lãi");
            dt.Columns.Add("Dàn Số");
            int Top = 100;
            int STT = 0;
            Task.Run(() =>
            {
                var alldate = SqlModule.GetDataTable("SELECT  [Date] FROM  [ResultOfDay2]");
                foreach (DataRow it in alldate.Rows)
                {
                    STT++;
                    //     if (STT< alldate.Rows.Count- Top)
                    if (STT < Top)
                    {
                        continue;
                    }

                    var i = DateTime.Parse(it[0].ToString());
                    var txtdate = i.ToString("yyyy-MM-dd HH:mm");

                    if (SqlModule.GetDataTable($"select Date from ResultOfDay2 where date='{txtdate}'").Rows.Count == 0 && i.Date != DateTime.Now.Date)
                    {
                        continue;
                    }
                    cau++;

                    var all = SqlModule.GetDataTable($@" select STRING_AGG(value,' ') value from [V_ResultOfDay2]
                                where date= ( select top 1 date from [V_ResultOfDay2] where  [DATE] <'{txtdate}'  order by date desc)");

                    var allok = all.Rows[0][0].ToString();
                    this.Invoke(new Action(() => label1.Text = txtdate));
                    var result = SqlModule.GetDataTable($@" select TOP 65 BT from 

V_DataNumber where bt   in (SELECT TOP {100}   RIGHT(DB, 2) AS BT  FROM[SC].[dbo].[ResultOfDay2] where[DATE] < '{txtdate}' ORDER BY DATE DESC)");

                    var OK = new List<int>();
                    int total = result.Rows.Count;

                    foreach (DataRow item in SqlModule.GetDataTable($"SELECT [BT] FROM  [V_ResultOfDay2] where date='{txtdate}' and giai='DB'").Rows)
                    {
                        OK.Add(int.Parse(item["BT"].ToString()));
                    }
                    var filteredDataTable = OK.Distinct().Count();

                    List<int> AllNumber = new List<int>();
                    foreach (DataRow item in result.Rows)
                    {
                        AllNumber.Add(int.Parse(item["BT"].ToString()));
                    }
                    //     AllNumber = AllNumber.Where(z =>  allok.Contains(z.ToString())).ToList();

                    var lo = AllNumber.Distinct().ToList();

                    var vonnow = tileVon * lo.Count;
                    var lasttileVon = tileVon;
                    double LaiNow = 0;
                    if (AllNumber.Where(z => OK.Contains(z)).Count() > 0)
                    {

                        LaiNow = GetTiLeThuong() * tileVon;

                        cau = 0;
                        tileVon = GetTileVonDefault();




                    }
                    else
                    {

                        tileVon = tileVon + 2;
                        //     tileVon = (int)tileVon;
                        if (tileVon == 0)
                        {
                            tileVon = GetTileVonDefault();
                        }

                        if (cau >= 4)
                        {
                            tileVon = 0;

                        }
                    }


                    von += vonnow;
                    lai += LaiNow;


                    TongLai = TongLai - vonnow + LaiNow;

                    this.Invoke(new Action(() =>
                    {
                        if (result.Rows.Count > 0)
                        {
                            var row = dt.NewRow();
                            row["cau"] = cau;
                            row["Date"] = txtdate;
                            row["Tổng số đánh"] = AllNumber.Count;
                            row["Vốn"] = (vonnow * HeSo).ToString("#,###");
                            row["Lãi"] = (LaiNow * HeSo).ToString("#,###");
                            row["Tỉ lệ vốn"] = lasttileVon;
                            row["Tổng lãi"] = (TongLai * HeSo).ToString("#,###");
                            dt.Rows.Add(row);


                            row["Dàn Số"] = string.Join(" ", AllNumber.Select(z => z.ToString("00")));
                            var db = SqlModule.GetDataTable($"SELECT value FROM V_ResultOfDay2 WHERE DATE='{row["Date"]}' AND giai='DB'");
                            if (db.Rows.Count > 0)
                            {
                                row["ĐB"] = db.Rows[0][0].ToString();
                                int DB = int.Parse(row["ĐB"].ToString().Substring(3, 2));
                                if (AllNumber.Contains(DB))
                                {
                                    row["Trúng"] = "Có";
                                }

                            }

                        }
                    }));




                }
                dt.DefaultView.Sort = "Date DESC";

                var listvonthuc = dt.AsEnumerable().Select(z => double.Parse((z["Tổng lãi"].ToString() == "" ? "0" : z["Tổng lãi"].ToString()).Replace(",", ""))).Where(z => z < 0).ToList();
                double vonthuc = 0;
                if (listvonthuc.Count > 0)
                {
                    vonthuc = listvonthuc.Min(z => z);
                }

                vonthuc = Math.Abs(vonthuc);
                this.Invoke(new Action(() =>
                {

                    dataGridView1.DataSource = dt;
                    TongLai = TongLai * HeSo;
                    lai = lai * HeSo;
                    von = von * HeSo;
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Vốn thực : " + (vonthuc == 0 ? "0" : vonthuc.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng vốn  : " + von.ToString("#,###") + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tổng thu : " + (lai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Lãi : " + (TongLai.ToString("#,###")) + " vnd";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ : " + Math.Round(((float)lai - (float)von) / (float)von * 100, 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Tỉ lệ thực: " + Math.Round((vonthuc == 0 ? 100 : (((float)TongLai - (float)vonthuc) / (float)vonthuc * 100)), 0) + "%";
                    richTextBox1.Text += $"\n";
                    richTextBox1.Text += $"Số ngày trúng : " + dt.Select("Trúng <>''").Count() + @"\" + dt.Rows.Count;
                }));


            });
        }

        private void button37_Click(object sender, EventArgs e)
        {
            //var input = textBox1.Text.Trim().Split(' ').Where(z => !string.IsNullOrEmpty(z));
            char[] input = textBox1.Text.ToCharArray();

            var result = new List<string>();
            for (int i = 0; i < 100; i++)
            {
                var bt1 = i.ToString("00").Substring(0, 1);
                var bt2 = i.ToString("00").Substring(1, 1);
                if (input.Where(z=>z.ToString().Contains(bt1) || z.ToString().Contains(bt2)).Count()>0  )
                {
                    result.Add(i.ToString("00"));
                }
            }

            richTextBox1.Text = string.Join(",", result);
            label1.Text = result.Count + " nummber";

        }

        private void button38_Click(object sender, EventArgs e)
        {
            var input = textBox1.Text.Trim().Split(' ').Where(z => !string.IsNullOrEmpty(z));
            var result = new List<string>();
            for (int i = 0; i < 100; i++)
            {
                var bt1 = i.ToString("00").Substring(0, 1);
                var bt2 = i.ToString("00").Substring(1, 1);
                if (input.Contains(bt1) || input.Contains(bt2))
                {
                    result.Add(i.ToString("00"));
                }
            }

            richTextBox1.Text = string.Join(",", result);
            label1.Text = result.Count + " nummber";
        }

        private void button40_Click(object sender, EventArgs e)
        {


            var txt = richTextBox1.Text.Trim();
            txt = txt.Replace(" ", ",");
            txt = txt.Replace("-", "");
            txt = txt.Replace("\n", ",");
            txt = txt.Replace("\r", ",");
            var input = txt.Split(',').Where(z => !string.IsNullOrEmpty(z)).Select(z => int.Parse(z));
            var result = new List<string>();
            for (int i = 0; i < 100; i++)
            {

                if (!input.Contains(i))
                {
                    result.Add(i.ToString("00"));
                }
            }

            richTextBox1.Text = string.Join(",", result);
            label1.Text = result.Count + " nummber";
        }

        private void splitContainer1_Panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void textBox1_Leave(object sender, EventArgs e)
        {
             var text = textBox1.Text;
            text = text.Replace("\n", " ");
            text = text.Replace("\t", " ");
            text = text.Replace("\r", " ");

            textBox1.Text = text;


        }
    }
}
