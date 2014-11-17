import static com.sun.btrace.BTraceUtils.compare;

import org.springframework.beans.factory.support.RootBeanDefinition;

import com.sun.btrace.BTraceUtils.Aggregations;
import com.sun.btrace.aggregation.*;
import com.sun.btrace.annotations.*;

@BTrace(unsafe=true) public class CreateBeanProfiler {
    private static Aggregation aggregation = Aggregations.newAggregation(AggregationFunction.MAXIMUM);
    
    @OnMethod(clazz="org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory",
            method="doCreateBean", location=@Location(Kind.RETURN))
    public static void doCreateBeanExit(final String beanName, final RootBeanDefinition mbd, final Object[] args, @Duration long duration) { 
        AggregationKey key = Aggregations.newAggregationKey(beanName);
        Aggregations.addToAggregation(aggregation, key, duration/1000000L);
    }
    
    @OnMethod(clazz="java.io.PrintStream", method="println")
    public static void dumpCreateBeanReport(@Self Object self, String x) {
        if(self == System.out && compare("dumpCreateBeanReport", x)) {        
            Aggregations.printAggregation("Create bean report", aggregation, "%80s %15d");
        }
    }
}
