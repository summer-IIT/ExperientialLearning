@isTest
public without sharing class DataFactoryPrograms {
    public static IIT_Program__c createBSProgram() {
        // Create a single IIT_Progarm__c Bachelor of Science program
        IIT_Program__c program = new IIT_Program__c(
        Name = 'BS-AANL'
            , IIT_Program_Name__c = 'Bachelor of Science in Applied Analytics'
            , IIT_Level__c = 'Undergraduate'
            , IIT_Degree__c = 'Bachelor of Science'
            , IIT_Major__c = 'Applied Analytics'
            , IIT_College__c = 'Lewis College of Human Science'
            , IIT_Department__c = 'Psychology'
        );

        return program;
    }

    public static IIT_Program__c createCERProgram() {
        // Create a single IIT_Progarm__c Certificate program
        IIT_Program__c program = new IIT_Program__c(
            Name = 'CER-ASD'
            , IIT_Program_Name__c = 'Certificate in Advanced Software Development'
            , IIT_Level__c = 'Graduate'
            , IIT_Degree__c = 'Certificate'
            , IIT_Major__c = 'Advanced Software Development'
            , IIT_College__c = 'School of Applied Technology'
            , IIT_Department__c = 'Information Technology and Management'
        );

        return program;
    }

    public static IIT_Program__c createMASProgram() {
        // Create a single IIT_Progarm__c Master program
        IIT_Program__c program = new IIT_Program__c(
            Name = 'MAS-DSC'
            , IIT_Program_Name__c = 'Master in Data Science'
            , IIT_Level__c = 'Graduate'
            , IIT_Degree__c = 'Master'
            , IIT_Major__c = 'Data Science'
            , IIT_College__c = 'College of Science'
            , IIT_Department__c = 'Computer Science'
        );
        return program;
    }

    public static IIT_Program__c createMSProgram() {
        // Create a single IIT_Progarm__c Master of Science program
        IIT_Program__c program = new IIT_Program__c(
            Name = 'MS-BME'
            , IIT_Program_Name__c = 'Master of Science in Biomedical Engineering'
            , IIT_Level__c = 'Graduate'
            , IIT_Degree__c = 'Master of Science'
            , IIT_Major__c = 'Biomedical Engineering'
            , IIT_College__c = 'Armour College of Engineering'
            , IIT_Department__c = 'Biomedical Engineering'
        );
        
        return program;
    }

    public static IIT_Program__c createNDGProgram() {
        // Create a single IIT_Progarm__c Non Degree Graduate program
        IIT_Program__c program = new IIT_Program__c(
            Name = 'NDG-BA-1'
            , IIT_Program_Name__c = 'Non Degree Graduate in Business Administration'
            , IIT_Level__c = 'Graduate'
            , IIT_Degree__c = 'Non Degree Graduate'
            , IIT_Major__c = 'Business Administration'
            , IIT_College__c = 'Stuart School of Business'
            , IIT_Department__c = 'Business Administration'
        );

        return program;
    }

    public static List<IIT_Program__c> createPrograms() {
        // Create a list of each different IIT_Program__c availble for testing.
        // Always contains the same 5 programs created by other create methods 
        List<IIT_Program__c> programs = new List<IIT_Program__c>();

        programs.add(DataFactoryPrograms.createBSProgram());
        programs.add(DataFactoryPrograms.createCERProgram());
        programs.add(DataFactoryPrograms.createMASProgram());
        programs.add(DataFactoryPrograms.createMSProgram());
        programs.add(DataFactoryPrograms.createNDGProgram());

        return programs;
    }
    
	public static List<IIT_Program__c> createAndInsertPrograms() {
		// Convenience method that wraps test methods
		// creates a list of the available test program objects and inserts the objects into the database
		List<IIT_Program__c> programs = DataFactoryPrograms.createPrograms();
		Database.SaveResult[] saveProgramResult = Database.insert(programs, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveProgramResult);		
		
		return programs;
	}
}