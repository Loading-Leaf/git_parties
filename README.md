# git_parties
このアプリケーションはGithubのディレクトリを検索し、
詳細を確認できるモノである。

## 主な機能
<ul>
    <li>リポジトリ検索</li>
    <li>リポジトリの詳細を確認</li>
    <li>スター数やフォーク数などに基づく並び替え</li>
    <li>言語変更</li>
</ul>

## ディレクトリ
lib<br>
├materials<br>
│ └color_settting.dart→文字の色と背景色を変更<br>
│ └language_provider.dart→言語設定をするためのプロバイダー<br>
├screens<br>
│ └main_page.dart→起動後のページ<br>
│ └repogitories_specific.dart→起動後のページ<br>
└main.dart→プロジェクトを統括<br>

## こだわった点
<ul>
    <li>時間に基づいてappbarの背景を変える点(朝:薄い水色, 昼:水色, 夕:オレンジ, 夜:紺色 )</li>
    <li>並び替え(降順や昇順が可能)</li>
    <li>右上の地球ロゴを押したら英語及び日本語に変更が可能</li>
    <li>第３者によるフィードバック</li>
</ul>


## 作業日記

### 作業日程
4/8: FigmaによるUIデザイン<br>
4/12: 基本動作の実装(参考サイト: https://github.com/yumemi-inc/flutter-engineer-codecheck)<br>
4/13(予定):知人を通したテストプレイ, 言語設定<br>
4/14(予定): コメントアウト, UI修正<br>
4/15(予定): 全体的なリファクタリング<br>

### 日報
4/12
実装した内容<br>
・Github API全般について学んだ→実装すべき機能を実装した<br>

・検索画面<br>
<img src="image.png" alt="alt text" width="300"/>

・リポジトリの詳細<br>
<img src="image-1.png" alt="alt text" width="300"/>

4/15
実装した内容<br>
・時間に応じたbarの色の変更<br>
・言語変更<br>
・並び替え(降順や昇順が可能)<br>

・夕方に使用した場合の検索結果<br>
<img src="https://github.com/user-attachments/assets/f3e502c8-07f1-4b1a-ac1e-a19e1d874a9d" alt="Screenshot_20250415-190607" width="300"/>

・英語表記<br>
<img src="https://github.com/user-attachments/assets/8054651f-1157-4ad9-90c8-0ed2fd92bdca" alt="Screenshot_20250415-190607" width="300"/>


・リポジトリの詳細<br>
<img src="https://github.com/user-attachments/assets/18513110-1c81-4c30-a4a5-0f924c088f96" alt="Screenshot_20250415-190607" width="300"/>

### 知人に聞くテストプレイの指標
<ul>
    <li>良かった点</li>
    <li>改善点</li>
    <li>欲しい機能</li>
    <li>感想</li>
</ul>

4/14、1人のテストユーザーと対面で合うので、口頭で話す予定

### 得た内容
<ul>
    <li>良かった点</li>
    <p>・十分良い</p>
    <p>・きれいにまとまっている</p>
    <p>・UIは見やすい</p>
    <li>改善点</li>
    <p>・検索最中でレコメンドを表示するとめちゃくちゃ良い</p>
    <li>欲しい機能</li>
    <p>・検索バーをリッチにする→実装済み</p>
    <p>・フォーク数や星の数で降順昇順にする→実装済み</p>
    
</ul>



### errorの原因
・Methods can't be invoked in constant expressions.dart(const_eval_method_invocation)<br>
→色を更新する時は、constを使用していたため<br>
const: 値の変更ができない<br>

・The method '_getAppBarColor' isn't defined for the type '_HomePageState'.<br>
Try correcting the name to the name of an existing method, or defining a method named '_getAppBarColor'.dartundefined_method<br>
→別途ファイルとしてmaterials/color_setting.dartに色変更するための関数を定義<br>
→自身のスペルミスが原因<br>
・例<br>
誤: gettitletextcolor →正: getTitleTextColor<br>
