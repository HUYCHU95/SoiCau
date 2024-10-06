using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    public class bachthu
    {
        public class ObjResult
        {
            public string DATE { get; set; }
            public string GIAI { get; set; }
            public string Value { get; set; }
            public int Number { get; set; }
            public string ViTri1 { get; set; }
            public string ViTri2 { get; set; }
            public string STT { get; set; }
        }
        public class ObjVitri
        {
            public string BT { get; set; }
            public string BTnow { get; set; }
            public string BT1 { get; set; }
            public string BT2 { get; set; }
            public string DATE { get; set; }
            public string value1 { get; set; }
            public string value2 { get; set; }
            public string ViTri1 { get; set; }
            public string ViTri2 { get; set; }
        }
        public void BACHTHU()
        {
            DateTime Startdate = DateTime.Parse("2021-01-26");
            //for (DateTime date = Startdate; date.Year == 2021; date = date.AddDays(-1))
            {
                DateTime date = DateTime.Parse("2021-01-28");


                var now = GetlastDay(date.ToString("yyyy-MM-dd"));
                for (int i = 1; i <=1; i++)
                {
                    var last = GetlastDay(date.AddDays(-i).ToString("yyyy-MM-dd"));
                      now = (from a in now join b in last on a.ViTri1 equals b.ViTri1 where a.ViTri1 == b.ViTri1 && a.ViTri2 == b.ViTri2 select a).Distinct().ToList();

                }
                foreach (var row in now)
                {
                    var STT1 = row.ViTri1.Substring(0,row.ViTri1.Length-2);
                    var STT2 = row.ViTri2.Substring(0, row.ViTri2.Length - 2);
                    var ViTri1 = row.ViTri1.Substring(STT1.Length,2);
                    var ViTri2 = row.ViTri2.Substring(STT2.Length, 2);

                    row.BT1 = SqlModule.GetDataTable($"SELECT VALUE FROM SC.dbo.V_ResultOfDay WHERE   date = dateadd(day,1,'{DateTime.Parse(row.DATE).ToString("yyyy-MM-dd")}') and  STT='" +   STT1 + "'").Rows[0][0].ToString();
                    row.BT1 = row.BT1.Substring(int.Parse(ViTri1) - 1, 1);

                    row.BT2 = SqlModule.GetDataTable($"SELECT VALUE FROM SC.dbo.V_ResultOfDay WHERE   date = dateadd(day,1,'{DateTime.Parse(row.DATE).ToString("yyyy-MM-dd")}') and  STT='" + STT2 + "'").Rows[0][0].ToString();
                    row.BT2 = row.BT2.Substring(int.Parse(ViTri2) - 1, 1);
                    row.BTnow = row.BT1 + row.BT2;
                }

                string AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location).ToString();
                var filepath = AssemblyPath + "\\result4.csv";
                csv.CreateCSVFromGenericList<ObjVitri>(now, filepath);

                System.Diagnostics.Process.Start(filepath);
                //var last = GetlastDay(date.AddDays(-1).ToString("yyyy-MM-dd"));
                //var last2 = GetlastDay(date.AddDays(-2).ToString("yyyy-MM-dd"));
                //var last3 = GetlastDay(date.AddDays(-3).ToString("yyyy-MM-dd"));
                //var last4 = GetlastDay(date.AddDays(-4).ToString("yyyy-MM-dd"));

                //var result = (from a in now join b in last on a.ViTri1 equals b.ViTri1 where a.ViTri1 == b.ViTri1 && a.ViTri2 == b.ViTri2 select a).Distinct().ToList();
                //var result2 = (from a in result join b in last2 on a.ViTri1 equals b.ViTri1 where a.ViTri1 == b.ViTri1 && a.ViTri2 == b.ViTri2 select a).Distinct().ToList();
                //var result3 = (from a in result2 join b in last3 on a.ViTri1 equals b.ViTri1 where a.ViTri1 == b.ViTri1 && a.ViTri2 == b.ViTri2 select a).Distinct().ToList();
                //var result4 = (from a in result3 join b in last4 on a.ViTri1 equals b.ViTri1 where a.ViTri1 == b.ViTri1 && a.ViTri2 == b.ViTri2 select a).Distinct().ToList();
                //string AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location).ToString();
                //var filepath = AssemblyPath + "\\result4.csv";
                //csv.CreateCSVFromGenericList<ObjVitri>(result4, filepath);

                //System.Diagnostics.Process.Start(filepath);
                // Use ToCharArray to convert string to array.
            }
        }
        public List<ObjVitri> GetlastDay(string date)
        {
            var result = new List<ObjVitri>();
            var number = SqlModule.GetDataTable($"select  BT from V_ResultOfDay where date = CONVERT(date,'{date}') and giai='DB' ");
            foreach (DataRow item in number.Rows)
            {
            var bt = item[0].ToString().ToCharArray().Select(z => z.ToString()).ToList();

                var befer = SqlModule.GetDataTable($"select DATE, GIAI,value,STT from V_ResultOfDay where  date =  DATEADD(DAY,-1,CONVERT(date,'{date}'))");
                var last = Convert(befer, bt).Distinct().ToList();
                result.AddRange(last);
            }

            return result;
        }
        public List<ObjVitri> Convert(DataTable input, List<string> bt)
        {
            var result = new List<ObjResult>();
            var newresult = new List<ObjVitri>();

            foreach (DataRow item in input.Rows)
            {
                var GIAI = item["GIAI"].ToString();
                var DATE = item["DATE"].ToString();
                var value = item["value"].ToString();
                var STT = item["STT"].ToString();
                int i = 0;
                foreach (var it in value.ToCharArray().Select(z => z.ToString()).ToList())
                {
                    i++;
                    if (!bt.Contains(it))
                    {
                        continue;
                    }
                    var row = new ObjResult();
                    row.DATE = DATE;
                    row.Value = value;
                    row.STT = STT;
                    row.Number = int.Parse(it);
                    row.ViTri1 = i.ToString("00");
                    result.Add(row);
                }

            }

            var vt1 = result.Where(z => z.Number == int.Parse(bt[0])).ToList();
            var vt2 = result.Where(z => z.Number == int.Parse(bt[1])).ToList();
            foreach (var item in vt1)
            {
                foreach (var it in vt2)
                {
                    var row = new ObjVitri();
                    row.DATE = it.DATE;
                    row.value1 = item.Value;
                    row.value2 = it.Value;
                    row.BT = string.Join("", bt);
                    row.ViTri1 = item.STT + item.ViTri1;
                    row.ViTri2 = it.STT + it.ViTri1;
                  
                    newresult.Add(row);
                }
            }
            foreach (var item in vt2)
            {
                foreach (var it in vt1)
                {
                    var row = new ObjVitri();
                    row.DATE = it.DATE;
                    row.BT = string.Join("", bt);
                    row.value1 = item.Value;
                    row.value2 = it.Value;
                    row.ViTri1 = item.STT + item.ViTri1;
                    row.ViTri2 = it.STT + it.ViTri1;


                    newresult.Add(row);
                }
            }
            return newresult.Distinct().ToList();
        }
    }
}
