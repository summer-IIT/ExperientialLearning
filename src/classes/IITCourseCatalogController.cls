public with sharing class IITCourseCatalogController {

    public id Current_Course_Id;
    public string collegeKey;
    public string departmentKey;
    public string areaofstudyKey;
    public string termKey;
    public list<IIT_Courses__c> coursesearchlist {get;set;}
    public string searchstring {get;set;}
   
    public IITCourseCatalogController(ApexPages.StandardController controller) {
        
        Current_Course_Id = controller.getRecord().id;
        collegeKey = System.currentPageReference().getParameters().get('c');
        departmentKey = System.currentPageReference().getParameters().get('d');
        areaofstudyKey = System.currentPageReference().getParameters().get('a');
        termKey = System.currentPageReference().getParameters().get('t');
        
    }
    
    public List<IIT_Courses__c> getIITCourses(){
       List<IIT_Courses__c> IITCourses = [
           SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, IIT_Major__c, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, IIT_College__c, IIT_Course_Title__c, IIT_Course_Description__c, IIT_Course_Picture__c, IIT_Area_of_Study__c, IIT_Available_Online__c, IIT_Contract__c, IIT_Instructor_Name__c, IIT_Instructor_Biography__c, IIT_Department__c, IIT_Fall_Term__c, IIT_Spring_Term__c, IIT_Summer_Term__c, IIT_Capacity__c, IIT_Lecture_Credits__c, IIT_Lab_Credits__c, IIT_Total_Credits__c, IIT_Prerequisites__c, IIT_Corequisites__c, IIT_Recommended__c, IIT_Popularity__c, IIT_Instructor_Picture__c FROM IIT_Courses__c order by Name asc];
       return IITCourses;
    }
    
     public List<IIT_Courses__c> getIITPopCourses(){
       List<IIT_Courses__c> IITPopCourses = [
           SELECT Id, OwnerId, IsDeleted, IIT_Major__c, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, IIT_College__c, IIT_Course_Title__c, IIT_Course_Description__c, IIT_Course_Picture__c, IIT_Area_of_Study__c, IIT_Available_Online__c, IIT_Contract__c, IIT_Instructor_Name__c, IIT_Instructor_Biography__c, IIT_Department__c, IIT_Fall_Term__c, IIT_Spring_Term__c, IIT_Summer_Term__c, IIT_Capacity__c, IIT_Lecture_Credits__c, IIT_Lab_Credits__c, IIT_Total_Credits__c, IIT_Prerequisites__c, IIT_Corequisites__c, IIT_Recommended__c, IIT_Popularity__c, IIT_Instructor_Picture__c FROM IIT_Courses__c order by IIT_Popularity__c desc];
       return IITPopCourses;
    }
    
    public List<Schema.PicklistEntry> getColleges() {
        return IIT_Courses__c.fields.IIT_College__c.getDescribe().getpicklistvalues();
    }
    
    public List<Schema.PicklistEntry> getDepartments() {
        return IIT_Courses__c.fields.IIT_Department__c.getDescribe().getpicklistvalues();
    }
    
    public List<Schema.PicklistEntry> getAreasOfStudy() {
        return IIT_Courses__c.fields.IIT_Area_of_Study__c.getDescribe().getpicklistvalues();
    }
    
    public string getCollegeKey() {
        return collegeKey;
    }
    
    public string getDepartmentKey() {
        return departmentKey;
    }
    
    public string getAreaOfStudyKey() {
        return areaofstudyKey;
    }
    
    public string getTermKey() {
        return termKey;
    }
    
    public void search(){
        string searchquery = 'select Id, Name, IIT_Course_Title__c ' +
							'from IIT_Courses__c ' +
            				'where Name like \'%'+searchstring+'%\' or ' +
            				'IIT_Course_Title__c like \'%'+searchstring+'%\' or ' +
            				'IIT_Department__c like \'%'+searchstring+'%\' or ' +
            				'IIT_College__c like \'%'+searchstring+'%\' or ' +
            				'IIT_Major__c like \'%'+searchstring+'%\' or ' +
            				'IIT_Area_of_Study__c like \'%'+searchstring+'%\' ' +
            				'order by Name asc';
        coursesearchlist = Database.query(searchquery);
    }
    
    public void clear(){
        coursesearchlist.clear();
    }
    
}