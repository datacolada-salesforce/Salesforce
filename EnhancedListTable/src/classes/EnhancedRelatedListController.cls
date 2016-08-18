public class EnhancedRelatedListController {
	
    public String objectAPI {get; set;}
    public String fieldSetName {get; set;}
    //public List<String> fields {get; set;}
    private List<Schema.FieldSetMember> fieldSetMemberList;
    private List<sObject> results;
    
    public EnhancedRelatedListController(){
        
    }
    
    public List<Schema.FieldSetMember> getFieldSetMemberList(){
        System.debug('--- objectAPI: ' + objectAPI);
        System.debug('--- fieldSetName: ' + fieldSetName);
        fieldSetMemberList = getFieldSet(fieldSetName, objectAPI);
        return fieldSetMemberList;
    }
    
    public List<sObject> getResults(){
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSetMemberList){
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM ' + objectAPI;
        System.debug('--- query: ' + query);
        results = Database.query(query);
        return results;
    }
    /*
    public void doAction(){
        System.debug('--- objectAPI: ' + objectAPI);
        System.debug('--- fieldSetName: ' + fieldSetName);
        fieldSetMemberList = getFieldSet(fieldSetName, objectAPI);
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : fieldSetMemberList){
            query += f.getFieldPath() + ', ';
        }
        query += 'Id, Name FROM ' + objectAPI;
        System.debug('--- query: ' + query);
        results = Database.query(query);
    }
    */
    public static List<Schema.FieldSetMember> getFieldSet(String fieldSetName, String ObjectName){
        
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
    
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
    
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
    
        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
        return fieldSetObj.getFields(); 
	}  
}