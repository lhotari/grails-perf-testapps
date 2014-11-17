import static com.sun.btrace.BTraceUtils.compare;

import org.springframework.beans.factory.support.RootBeanDefinition;

import com.sun.btrace.BTraceUtils;
import com.sun.btrace.Profiler;
import com.sun.btrace.annotations.*;

@BTrace(unsafe=true) public class CreateBeanProfiler {
    @Property(name="createbean-profiler")
    public static Profiler profiler = BTraceUtils.Profiling.newProfiler();
    
    @OnMethod(clazz="org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory",
            method="doCreateBean")
    public static void doCreateBeanEntry(final String beanName, final RootBeanDefinition mbd, final Object[] args) { 
        BTraceUtils.Profiling.recordEntry(profiler, beanName);
    }
    
    @OnMethod(clazz="org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory",
            method="doCreateBean", location=@Location(Kind.RETURN))
    public static void doCreateBeanExit(final String beanName, final RootBeanDefinition mbd, final Object[] args, @Duration long duration) { 
        BTraceUtils.Profiling.recordExit(profiler, beanName, duration/1000000L);
    }
    
    @OnMethod(clazz="java.io.PrintStream", method="println")
    public static void dumpCreateBeanReport(@Self Object self, String x) {
        if(self == System.out && compare("dumpCreateBeanReport", x)) {        
            BTraceUtils.Profiling.printSnapshot("Create bean profiling snapshot", profiler, "%1$s %2$s %8$s %9$s %10$s");
        }
    }
}
