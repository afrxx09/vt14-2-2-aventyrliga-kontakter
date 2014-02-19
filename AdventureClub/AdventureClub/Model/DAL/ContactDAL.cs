using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AdventureClub.Model.DAL
{
    public class ContactDAL : DALBase
    {
        public void DeleteContact(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspRemoveContact", conn);
                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = contactId;
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new Exception("Gick inte ta bort Kontakt.");
                }
            }
        }

        public Contact GetContactById(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspGetContact", conn);
                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = contactId;
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    using(var reader = cmd.ExecuteReader())
                    {
                        var contactIdIndex = reader.GetOrdinal("ContactId");
                        var firstNameIndex = reader.GetOrdinal("FirstName");
                        var lastNameIndex = reader.GetOrdinal("LastName");
                        var emailIndex = reader.GetOrdinal("EmailAddress");
                        if (reader.Read())
                        {
                            return new Contact
                            {
                                ContactId = reader.GetInt32(contactIdIndex),
                                FirstName = reader.GetString(firstNameIndex),
                                LastName = reader.GetString(lastNameIndex),
                                Email = reader.GetString(emailIndex)
                            };
                        }
                        else
                        {
                            throw new Exception();
                        }
                    }
                }
                catch
                {
                    throw new Exception("Kunde inte hämta kontakt.");
                }
            }
        }
        public IEnumerable<Contact> GetContacts()
        {
            using(var conn = CreateConnection())
            {
                try
                {
                    var contacts = new List<Contact>(100);
                    var cmd = new SqlCommand("Person.uspGetContacts", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        var contactIdIndex = reader.GetOrdinal("ContactId");
                        var firstNameIndex = reader.GetOrdinal("FirstName");
                        var lastNameIndex = reader.GetOrdinal("LastName");
                        var emailIndex = reader.GetOrdinal("EmailAddress");
                        
                        while (reader.Read())
                        {
                            contacts.Add(new Contact
                            {
                                ContactId = reader.GetInt32(contactIdIndex),
                                FirstName = reader.GetString(firstNameIndex),
                                LastName = reader.GetString(lastNameIndex),
                                Email = reader.GetString(emailIndex)
                            });
                        }
                        contacts.TrimExcess();

                        return contacts;
                    }
                }
                catch
                {
                    throw new Exception();
                }
            }
        }
        public IEnumerable<Contact> GetContactsPageWise(int maxRows, int startRow, int totalRows)
        {
            throw new ArgumentException();
        }
        public void InsertContact(Contact c)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspAddContact", conn);
                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar, 50).Value = c.FirstName;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar, 50).Value = c.LastName;
                    cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar, 50).Value = c.Email;

                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    c.ContactId = (int)cmd.Parameters["@ContactId"].Value;
                }
                catch
                {
                    throw new Exception("Kunde inte lägga in ny kontakt.");
                }
            }
        }

        public void UpdateContact(Contact c)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("Person.uspUpdateContact", conn);
                    cmd.Parameters.AddWithValue("@ContactId", c.ContactId);
                    cmd.Parameters.AddWithValue("@FirstName", c.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", c.LastName);
                    cmd.Parameters.AddWithValue("@EmailAddress", c.Email);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new Exception("Kunde inte lägga in ny kontakt.");
                }
            }
        }

    }
}