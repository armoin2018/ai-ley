// Trigger Handler Pattern for Apex Development
public class AccountTriggerHandler {
    public static void beforeInsert(List<Account> newAccounts) {
        AccountBusinessLogic.validateAccountData(newAccounts);
        AccountBusinessLogic.setDefaultValues(newAccounts);
    }
    
    public static void afterInsert(List<Account> newAccounts) {
        AccountBusinessLogic.createRelatedRecords(newAccounts);
        AccountBusinessLogic.publishPlatformEvents(newAccounts);
    }
    
    public static void beforeUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        AccountBusinessLogic.validateBusinessRules(newAccounts, oldAccountMap);
        AccountBusinessLogic.updateRelatedRecords(newAccounts, oldAccountMap);
    }
}

// Separation of Concerns with Business Logic Class
public class AccountBusinessLogic {
    public static void validateAccountData(List<Account> accounts) {
        for (Account acc : accounts) {
            if (acc.AnnualRevenue != null && acc.AnnualRevenue < 0) {
                acc.addError('Annual Revenue cannot be negative');
            }
        }
    }
    
    public static void createRelatedRecords(List<Account> accounts) {
        List<Contact> contactsToInsert = new List<Contact>();
        for (Account acc : accounts) {
            if (acc.Type == 'Customer - Direct') {
                Contact defaultContact = new Contact(
                    AccountId = acc.Id,
                    LastName = acc.Name + ' - Primary Contact',
                    Email = 'contact@' + acc.Website
                );
                contactsToInsert.add(defaultContact);
            }
        }
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}