using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    public class SendMail
    {
        public static bool SendEmail(string[] _email, string Subject, string body, List<string> Link = null, string Title = "", string[] _CC = null)
        {

            //        Thread.Sleep(200);
            string senderID = "No.Reply@robotech.com.vn";
            string senderPassword = "6Khoi1356";

            try
            {

                MailMessage mail = new MailMessage();
                foreach (var item in _email)
                {
                    mail.To.Add(item);
                }

                if (_CC != null)
                {
                    foreach (var item in _CC)
                    {
                        mail.CC.Add(item);

                    }
                }
                if (Title != "" && Title != null)
                {
                    mail.From = new MailAddress(senderID, Title);

                }
                else
                {
                    mail.From = new MailAddress(senderID);

                }
                mail.Subject = Subject;
                mail.Body = body;
                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.office365.com"; //Or Your SMTP Server Address
                smtp.Credentials = new System.Net.NetworkCredential(senderID, senderPassword);
                smtp.Port = 587;
                smtp.EnableSsl = true;
                if (Link != null)
                {
                    foreach (var item in Link)
                    {
                        var attachment = new Attachment(item);
                        mail.Attachments.Add(attachment);
                    }

                }
                smtp.Send(mail);
                return true;

            }
            catch (Exception ex)
            {

               
                return false;
            }
        }

    }
}
