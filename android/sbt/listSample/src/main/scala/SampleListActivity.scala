package fits.sample

import android.app.ListActivity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.Toast;

class SampleListActivity extends ListActivity {
	override def onCreate(savedInstanceState: Bundle) {
		super.onCreate(savedInstanceState)

		setContentView(R.layout.main)

		val adapter = new ArrayAdapter(this, R.layout.item, R.id.name, Array("20100903_Sinatra風PHP用フレームワークLimonadeによるWebアプリケーション作成", "20100906_F#でASP.NET", "20100909_ScalaでAndroidアプリ"))

		//リストアイテムの設定
		setListAdapter(adapter)
	}

	//リストアイテムをクリックした際の処理
	override def onListItemClick(l: ListView, v: View, p: Int, id: Long) {
		//クリックしたアイテムを取得
		val selectedItem = l.getItemAtPosition(p)

		val intent = new Intent(this, classOf[ItemDetailActivity])
		intent.putExtra("ITEM", selectedItem.toString())

		startActivity(intent)

	//	Toast.makeText(this, "item select : " + selectedItem, Toast.LENGTH_SHORT).show()

	}
}

