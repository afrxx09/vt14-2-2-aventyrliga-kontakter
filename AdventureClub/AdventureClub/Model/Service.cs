using AdventureClub.Model.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AdventureClub.Model
{
    public class Service
    {
        private ContactDAL _contactDAL;
        public ContactDAL ContactDAL { get { return _contactDAL ?? (_contactDAL = new ContactDAL()); } }

        public void DeleteContact(int contactId)
        {
            ContactDAL.DeleteContact(contactId);
        }

        public void DeleteContact(Contact c)
        {
            ContactDAL.DeleteContact(c.ContactId);
        }

        public Contact GetContact(int contactId)
        {
            return ContactDAL.GetContactById(contactId);
        }

        public IEnumerable<Contact> GetContacts()
        {
            return ContactDAL.GetContacts();
        }

        public IEnumerable<Contact> GetContactsPageWise(int maxRows, int startRow, int TotalRows)
        {
            throw new ArgumentException();
        }

        public void SaveContact(Contact c)
        {
            if (c.ContactId > 0)
            {
                ContactDAL.UpdateContact(c);
            }
            else
            {
                ContactDAL.InsertContact(c);
            }

        }
    }
}