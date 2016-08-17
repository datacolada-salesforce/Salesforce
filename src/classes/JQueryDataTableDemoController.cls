public class JQueryDataTableDemoController {
	
    public List<Account> accountList {get; set;}
    
    public JQueryDataTableDemoController(){
        accountList = [Select Id, Name, Industry, NumberOfEmployees, Phone, Fax From Account limit 10000];
    }
    
    
}