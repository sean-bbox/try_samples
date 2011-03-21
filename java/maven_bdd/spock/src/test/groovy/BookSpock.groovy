package fits.sample

import spock.lang.*

class InitBookSpecTest extends Specification {
	def b = new Book()

	def "title は null"() {
		expect:
			b.title == null
	}

	def "comments は null ではない"() {
		expect:
			b.comments != null
	}

	def "comments は空"() {
		expect:
			b.comments.size == 0
	}
}

class SetTitleSpecTest extends Specification {
	def b = new Book()

	def "title を指定"() {
		when:
			b.title = "test"

		then:
			b.title == "test"
	}
}

class AddCommentSpecTest extends Specification {
	def b = new Book()

	def "Comment を追加"() {
		when:
			b.comments.add(new Comment())
		then:
			b.comments.size == 1
	}
}
