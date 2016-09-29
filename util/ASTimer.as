/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package devoron.aswing3d.util{
	
import flash.events.TimerEvent;
import flash.utils.clearInterval;
import flash.utils.setInterval;
import flash.utils.Timer;
import devoron.aswing3d.event.AWEvent;
/**
 * Fires one or more action events after a specified delay.  
 * For example, an animation object can use a <code>Timer</code>
 * as the trigger for drawing its frames.
 *
 * <p>
 * Setting up a timer
 * involves creating a <code>Timer</code> object,
 * registering one or more action listeners on it,
 * and starting the timer using
 * the <code>start</code> method.
 * For example, 
 * the following code creates and starts a timer
 * that fires an action event once per second
 * (as specified by the first argument to the <code>Timer</code> constructor).
 * The second argument to the <code>Timer</code> constructor
 * specifies a listener to receive the timer's action events.
 * </p>
 * <pre>
 *  var delay:Number = 1000; //milliseconds
 *  var listener:Object = new Object();
 *  listener.taskPerformer = function(e:Event) {
 *          <em>//...Perform a task...</em>
 *      }
 *  var timer:Timer = new Timer(delay);
 *  timer.addActionListener(listener.taskPerformer);
 *  timer.start();
 * </pre>
 *
 * <p>
 * @author iiley
 */
public class ASTimer extends AbstractImpulser implements Impulser{
	private var timer:Timer;
	
	/**
	 * Construct Timer.
	 * @see #setDelay()
     * @throws Error when init delay <= 0 or delay == null
	 */
	public function ASTimer(delay:uint, repeats:Boolean=true){
		super(delay, repeats);
		timer = new Timer(delay, repeats ? 0 : 1);
		timer.addEventListener(TimerEvent.TIMER, fireActionPerformed);
	}
	
    /**
     * Starts the <code>Timer</code>,
     * causing it to start sending action events
     * to its listeners.
     *
     * @see #stop()
     */
    override public function start():void{
    	isInitalFire = true;
    	//clearInterval(intervalID);
    	//intervalID = setInterval(fireActionPerformed, getInitialDelay());
		timer.reset();
		timer.delay = getInitialDelay();
		timer.start();
    }
    
    /**
     * Returns <code>true</code> if the <code>Timer</code> is running.
     *
     * @see #start()
     */
    override public function isRunning():Boolean{
    	return timer.running;
    }
    
    /**
     * Stops the <code>Timer</code>,
     * causing it to stop sending action events
     * to its listeners.
     *
     * @see #start()
     */
    override public function stop():void{
    	//clearInterval(intervalID);
		timer.stop();
    	//intervalID = 0;
    }
    
    /**
     * Restarts the <code>Timer</code>,
     * canceling any pending firings and causing
     * it to fire with its initial delay.
     */
    override public function restart():void{
        stop();
        start();
    }
    
    private function fireActionPerformed(e:TimerEvent):void{
    	if(isInitalFire){
    		isInitalFire = false;
    		if(repeats){
    			//clearInterval(intervalID);
				timer.reset();
				//timer.addEventListener(TimerEvent.TIMER_COMPLETE, fireActionPerformed);
				timer.delay = getDelay()
				timer.start();
    			//intervalID = setInterval(fireActionPerformed,getDelay());
    		}else{
    			stop();
    		}
    	}
    	dispatchEvent(new AWEvent(AWEvent.ACT));
    }
    

	
}
}