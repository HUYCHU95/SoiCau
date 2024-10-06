using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    public class ResultOfDay
    {
        public string Date { get; set; }
        public string DB { get; set; }
        public string NHAT { get; set; }
        public string NHI { get; set; }
        public string BA { get; set; }
        public string TU { get; set; }
        public string NAM { get; set; }
        public string SAU { get; set; }
        public string BAY { get; set; }
        public string TAM { get; set; }
 
        public static void Insert(  ResultOfDay item)
        {
            var sql = $@"INSERT INTO[dbo].[ResultOfDay]
            ([Date]
          ,[DB]
          ,[NHAT]
          ,[NHI]
          ,[BA]
          ,[TU]
          ,[NAM]
          ,[SAU]
          ,[BAY]
          )
         VALUES
           (
           '{item.Date}'
            , N'{item.DB}'
           ,N'{item.NHAT}'
           ,N'{item.NHI}'
           ,N'{item.BA}'
           ,N'{item.TU}'
           ,N'{item.NAM}'
           ,N'{item.SAU}'
           ,N'{item.BAY}'
           
            )";
            SqlModule.ExcuteCommand(sql);
        }
    
        public  static List<string> getAllDay()
        { 
            var result = new List<string>();
            var data = SqlModule.GetDataTable(" SELECT  CONVERT(nvarchar(10),Date,120) from [ResultOfDay] where db!='' group by [Date]");
            foreach (DataRow item in data.Rows)
            {
                result.Add(item[0].ToString());
            }
            return result;
        }
    }
}
