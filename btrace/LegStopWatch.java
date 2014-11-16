import com.sun.btrace.BTraceUtils;
import static com.sun.btrace.BTraceUtils.*;
import com.sun.btrace.Profiler;
import com.sun.btrace.annotations.*;
import java.util.Deque;

@BTrace public class LegStopWatch {
    @Property(name="legstopwatch")
    public static Profiler profiler = BTraceUtils.Profiling.newProfiler();
    
    @TLS public static String startingpoint = "start";
    @TLS public static long startingtime = BTraceUtils.timeMillis();

    @OnProbe(
        namespace="legstopwatch-probes",
        name="legstopwatch-probe"
    )
    public static void leg(int lineno) { 
        String currentPoint = Strings.strcat(Strings.strcat(name(probeClass()), ":"), str(lineno));
        String currentLeg = Strings.strcat(Strings.strcat(startingpoint, "->"), currentPoint);
        long duration = BTraceUtils.timeMillis() - startingtime;
        BTraceUtils.Profiling.recordEntry(profiler, currentLeg);
        BTraceUtils.Profiling.recordExit(profiler, currentLeg, duration);
        startingtime = BTraceUtils.timeMillis();
        startingpoint = currentPoint;
    }
    
    @OnTimer(5000)
    public static void timer() {
        BTraceUtils.Profiling.printSnapshot("Leg stopwatch", profiler, "%1$s %2$s %8$s %9$s %10$s");
    }
}
