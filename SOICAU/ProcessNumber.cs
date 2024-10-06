using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
  public  class ProcessNumber
    {
        public  static float Process(int Input, Dictionary<DateTime, List<string>> lastResult,DateTime ToDate)
        {
            // tỉ lệ xuất hiện
            Dictionary<string, int> data=new Dictionary<string, int>();
            float result = 0;

            #region Kiểm tra có xuất hiện ở bảng trước không
            var yesterday = ToDate.AddDays(-1).Date;
            data.Add(ConstType.SuatHienOBangTruoc, 0);
             data.Add(ConstType.SuatHienOGiuaBangTruoc, 0);
            if (lastResult.ContainsKey(yesterday))
            {
                var datayesterday = lastResult[yesterday];
                if (datayesterday.Where(v=>int.Parse(v.PadRight(2)) ==Input).Count()>0)
                {
                    data[ConstType.SuatHienOBangTruoc] = 1;
                }
                if (datayesterday.Where(v => v.Contains(Input.ToString())).Count() > 0)
                {
                    data[ConstType.SuatHienOBangTruoc] = 1;

                }
            }
            #endregion
             #region Kiểm tra có xuất hiện ở giải  7 ngày
            var LastWeek = ToDate.AddDays(-7).Date;
            data.Add(ConstType.SuatHienOGiai7NgayTruoc, 0);
             if (lastResult.ContainsKey(LastWeek))
            {
                var datayesterday = lastResult[LastWeek];
                if (datayesterday.Where(v=>int.Parse(v.PadRight(2)) ==Input).Count()>0)
                {
                    data[ConstType.SuatHienOGiai7NgayTruoc] = 1;
                }
                //if (datayesterday.Where(v => v.Contains(Input.ToString())).Count() > 0)
                //{
                //    data[ConstType.SuatHienOGiai7NgayTruoc] = 1;

                //}
            }
            #endregion


            #region Thống kê tỉ lệ ra
            result = (float)data.Sum(z => z.Value)  /(float) data.Count() * 100 ;
            #endregion
            return result;
        }

    }
}
