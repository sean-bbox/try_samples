
import sodium.*

def batch = { Lambda1<Integer, Boolean> cond, int n, Event ev ->
	def counter = new BehaviorSink(n)
	def li = null

	li = ev.listen {
		def newValue = counter.sample() - 1
		counter.send newValue

		if (newValue <= 0) {
			li?.unlisten()
		}
	}
	ev.gate counter.map(cond)
}

def skip = batch.curry { it <= 0 }
def take = batch.curry { it > 0 }

def skipAndTake3 = skip.curry(1) >> take.curry(3)

def bh = new BehaviorSink(null)

def li = skipAndTake3(bh.updates()).map { "# ${it}" }.listen { println it }

new File(args[0]).eachLine { bh.send it }

li.unlisten()
