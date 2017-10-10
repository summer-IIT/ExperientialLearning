@isTest
public class testSortSelectOptions {

    public static testMethod void testSortSelectOptions() {
    
    List<SelectOption> so = new List<SelectOption>();
    
    
        so.add(new SelectOption('A', 'C'));
        so.add(new SelectOption('B', 'B'));
        so.add(new SelectOption('C', 'A'));
    
    
    
        so = SortSelectOptions.selectOptionSortByValue(so);
        system.assertEquals('A', so[0].getValue() );
        
        so = SortSelectOptions.selectOptionSortByLabel(so);
        system.assertEquals('C', so[0].getValue() ); 
    
    }
    
}