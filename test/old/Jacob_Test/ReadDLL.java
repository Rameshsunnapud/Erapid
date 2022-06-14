package jacobtest;

import com.jacob.activeX.*;
import com.jacob.com.*;
/**
 * This class uses the the Jacob tech
 * to use and interact with a Com cmponent 
 * in a java application
 */
public class ReadDLL {   
    
    public static void main(String[] args){
        
        //Loading the library:
        ActiveXComponent comp=new ActiveXComponent("Com.Calculation");        
        System.out.println("The Library been loaded, and an activeX component been created");
        
        int arg1=100;
        int arg2=50;
        //using the functions from the library:        
        int summation=Dispatch.call(comp, "sum",arg1,arg2).toInt();
        System.out.println("Summation= "+ summation);
        
        int subtraction= Dispatch.call(comp,"subtract",arg1,arg2).toInt();
        System.out.println("Subtraction= "+ subtraction);
        
        int multiplication=Dispatch.call(comp,"multi",arg1,arg2).toInt();
        System.out.println("Multiplication= "+ multiplication);
        
        double division=Dispatch.call(comp,"div",arg1,arg2).toDouble();
        System.out.println("Division= "+ division);
        
        /**The following code is abstract of using the get,
         * when the library contains a function that return
         * some kind of a struct, and then get its properties and values
         **/
//        Dispatch disp=Dispatch.call(comp,"sum",100,10).toDispatch();
//        DataType Var=Dispatch.get(disp,"Property Name");
    }
}
