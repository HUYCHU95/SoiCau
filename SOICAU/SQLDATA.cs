using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    class SQLDATA
    {
        public static Dictionary<DateTime,List<string>> V_ResultOfDay()
        {
            var lastResult = SqlModule.GetDataTable("SELECT DATE,value FROM [SC].[dbo].[V_ResultOfDay]");

            var result = new Dictionary<DateTime, List<string>>();
            foreach (DataRow item in lastResult.Rows)
            {
                var number = item["value"].ToString();
                var DATE = DateTime.Parse(item["DATE"].ToString());

                if (!result.ContainsKey(DATE))
                {
                    result.Add(DATE, new List<string>());
                }

                result[DATE].Add(number);
            }
            return result;
        }
    }
}
