; バトル画面

; 正解不正解のボタン2種
; 相手に正解のボタンを言わせておく
; 3回間違いでゲームオーバー
; 2回成功でエンディング

; ＊＊＊本来はバトル画面、エンディングでシナリオを分けるが、説明のため1ファイルにまとめる。＊＊＊

*retry
;===# キャラやらUIやら登録===
; scene1からそのままコピー＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝┐

    [cm  ]
    [clearfix]
    [start_keyconfig]


    ;## 背景を変更する場合ここを変更
    [bg storage="room.jpg" time="100"]

    ;メニューボタンの表示
    @showmenubutton

    ;メッセージウィンドウの設定
    [position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=true]

    ;文字が表示される領域を調整
    [position layer=message0 page=fore margint="45" marginl="50" marginr="70" marginb="60"]


    ;メッセージウィンドウの表示
    @layopt layer=message0 visible=true

    ;キャラクターの名前が表示される文字領域
    [ptext name="chara_name_area" layer="message0" color="white" size=28 bold=true x=180 y=510]

    ;上記で定義した領域がキャラクターの名前表示であることを宣言（これがないと#の部分でエラーになります）
    [chara_config ptext="chara_name_area"]

    ;このゲームで登場するキャラクターを宣言
    ;akane
    [chara_new  name="akane" storage="chara/akane/normal.png" jname="あかね"  ]
    ;キャラクターの表情登録
    [chara_face name="akane" face="angry" storage="chara/akane/angry.png"]
    [chara_face name="akane" face="doki" storage="chara/akane/doki.png"]
    [chara_face name="akane" face="happy" storage="chara/akane/happy.png"]
    [chara_face name="akane" face="sad" storage="chara/akane/sad.png"]

    ;yamato
    [chara_new  name="yamato"  storage="chara/yamato/normal.png" jname="やまと" ]

; /scene1.ksからそのままコピー＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝┘

;=== # その他オリジナル画面構成

    /*
    今回は最初から入っている素材を使う縛りをしているので、widthとheightを数値指定しているが、

    ＊＊＊ 本当は、そのpx数100%の画像素材を使用する。(一番処理が軽いため) ＊＊＊

    また、処理を軽くするのに、[preload]タグで最初に読み込ませてから使用するのがオススメ。(必要最低限のみ)
    */

    ;選択肢1(ONボタン)
    [button fix="true" name="btn0" graphic="config/c_skipon.png"           width="110" height="110" x="64"   y="35"        target="*result" exp="f.ans=0" ]
    ;選択肢2(OFFボタン)
    [button fix="true" name="btn1" graphic="config/button_unread_off.png"  width="110" height="110" x="174"  y="145"       target="*result" exp="f.ans=1" ]

    ;情報開示ゲージ(ボタンではないが、ボタンレイヤーに置く方がオススメ)
    [button fix="true" name="gue0" graphic="config/c_btn_back.png"         width="100" height="483" x="1116" y="36"        target="*none" ]
    ;情報開示メモリ(ゲージの中の○部分)
    [button fix="true" name="gue1,gue" graphic="config/c_btn_back2.png"    width="50"  height="50"  x="1165" y="&153+92*0" target="*none"]
    [button fix="true" name="gue2,gue" graphic="config/c_btn_back2.png"    width="50"  height="50"  x="1165" y="&153+92*1" target="*none"]
    [button fix="true" name="gue3,gue" graphic="config/c_btn_back2.png"    width="50"  height="50"  x="1165" y="&153+92*2" target="*none"]
    [button fix="true" name="gue4,gue" graphic="config/c_btn_back2.png"    width="50"  height="50"  x="1165" y="&153+92*3" target="*none"]

    ;相手の体力ゲージ
    [button fix="true" name="hp1,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="745"  y="153"       target="*none"]
    [button fix="true" name="hp2,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="770"  y="178"       target="*none"]
    [button fix="true" name="hp3,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="770"  y="212"       target="*none"]

    ;上記コピペ登録で行ったキャラクターを呼び出し

    ;こちらが対戦相手
    [chara_show name="akane"  layer="0" wait="false" ]
    ;こっちがプレイヤー側(手の代わりに巨大化画面下へ)
    [chara_show name="yamato" layer="1"  width="1500" top="400"  wait="true" ]

;=== /# その他オリジナル画面構成┘

;=== #変数を設定=============================================┐

    ;複数の変数を設定するときは[iscript]でJS表記にすると楽ですわよ。
    [iscript ]
    //この中ではコメント文は//で表す
        //初期化
        f.hp=3;//対戦相手のHP
        f.ifo=0;//取得した情報数
        f.ans=undefined;//自分が選んだ選択肢

        //今回は情報を既に2個抜いていることにする。
        f.ifo=2;
    [endscript ]

;=== /#変数を設定============================================┘


*fight
;=== #ボタンを変更=============================================┐

;変数の内容によりボタンの一部を変化させる。
    ;情報開示メモリ
        ;ifoが0以外の時
        [if exp="f.ifo!=0"]
            ;メモリボタンを全て削除
            [clearfix name="gue"]
            ;情報開示が1のとき
            [if exp="f.ifo==1"]
                    ;これはgue1が一番上、gue4が一番下
                    [button fix="true" name="gue1,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*0" target="*none"]
                    [button fix="true" name="gue2,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*1" target="*none"]
                    [button fix="true" name="gue3,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*2" target="*none"]
                    [button fix="true" name="gue4,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*3" target="*none"]
                    ;情報開示が2のとき
                    [elsif exp="f.ifo==2"]
                    [button fix="true" name="gue1,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*0" target="*none"]
                    [button fix="true" name="gue2,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*1" target="*none"]
                    [button fix="true" name="gue3,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*2" target="*none"]
                    [button fix="true" name="gue4,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*3" target="*none"]
                    ;情報開示が3のとき
                    [elsif exp="f.ifo==3"]
                    [button fix="true" name="gue1,gue" graphic="config/c_btn_back2.png" width="50"  height="50"  x="1165" y="&153+92*0" target="*none"]
                    [button fix="true" name="gue2,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*1" target="*none"]
                    [button fix="true" name="gue3,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*2" target="*none"]
                    [button fix="true" name="gue4,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*3" target="*none"]
                    ;情報開示が4のとき
                    [elsif exp="f.ifo==4"]
                    [button fix="true" name="gue1,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*0" target="*none"]
                    [button fix="true" name="gue2,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*1" target="*none"]
                    [button fix="true" name="gue3,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*2" target="*none"]
                    [button fix="true" name="gue4,gue" graphic="config/c_set.png"       width="50"  height="50"  x="1165" y="&153+92*3" target="*none"]
            [endif ]
        [endif ]

    ;相手の体力
        ;hpが3以外のとき
        [if exp="f.hp!=3"]
            ;体力ボタンを全て削除
            [clearfix name="hp"]
            ;hpが2のとき
            [if exp="f.hp==2"]
                    ;これは1が一番上、3が一番下の位置を指す
                    [button fix="true" name="hp1,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="745"  y="153"       target="*none"]
                    [button fix="true" name="hp2,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="770"  y="178"       target="*none"]
                    ;[button fix="true" name="hp3,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="770"  y="212"       target="*none"]
                    ;hpが1のとき
                    [elsif exp="f.hp==1"]
                    [button fix="true" name="hp1,hp" graphic="config/c_btn_back2.png"      width="25"  height="25"  x="745"  y="153"       target="*none"]
                    ;1~3以外のとき([clearfix]で全て消したまま)
                    [else ]
            [endif ]

        [endif ]

;=== /#ボタンを変更=============================================┘

;===　#ここからボタン選択待機画面=============================================┐

;対戦相手の残り体力により対戦相手の表情を変更する
    ;変数を初期化
    [eval exp="f.face='default'"]
        ;残り体力2のとき
        [if exp="f.hp==2"]
            [eval exp="f.face='sad'"]
            ;残り体力1のとき
            [elsif exp="f.hp==1"]
            [eval exp="f.face='angry'"]
            ;残り体力0のとき
            [elsif exp="f.hp==0"]
            [eval exp="f.face='doki'"]
        [endif ]
    ;数字によりf.faceの文字列が変更され、chara_modで適用します。
    [chara_mod name="akane" face="&f.face"]
        
;残り体力&情報開示数で対戦相手のセリフを変更します。
;上と同じく[if]~[elsif]~[endif]で書いてもいいんですけどしんどいのでJS式で記入します。短いし見やすい。
    [iscript ]
        if(f.hp==3)f.lineHP='体力満タンの時のセリフ';
        if(f.hp==2)f.lineHP='体力2の時のセリフ';
        if(f.hp==1)f.lineHP='体力1の時のセリフ';
        if(f.hp==0)f.lineHP='体力0の時のセリああああああああ！！！わざと間違えたでしょ！！！言ったじゃん！！正解言ってたじゃん！！！！！！！！！';

        if(f.ifo==0)f.lineIFO='ゲーム製作に興味ない？';
        if(f.ifo==1)f.lineIFO='ギクッ…';
        if(f.ifo==2)f.lineIFO='情報2の時のセリフ';
        if(f.ifo==3)f.lineIFO='情報3の時のセリフ';
        if(f.ifo==4)f.lineIFO='情報4の時のセリフ';
    [endscript ]

;変数で変更したセリフを対戦相手が話します。
#あかね
    ;情報4まで達成した場合の処理です。
        [if exp="f.ifo==4"]
            ;ボタン押されるとバグるので消しておきます。
            [clearfix]
            [emb exp="f.lineIFO"]
            ;クリアフラグ変数を作成します。
            [eval exp="f.clear=true"]
        [endif ]
        ;注意：この時、[if]~[endif]の中で[jump]しないようにしてください。バグります。


    ;ゲームオーバーの時だけ情報の時のセリフは入れないように表示させます。
    ;クリアフラグが出ているときは処理しません。
    [ignore exp="f.clear==true"]
        [if exp="f.hp==0"]
            [trace exp="f.clear"]
            ;ボタン押されるとバグるので消しておきます。
            [clearfix]
            [emb exp="f.lineHP"]
            [else ]
            ;ゲームクリアでもオーバーでもないセリフ
            [emb exp="f.lineIFO"][r][emb exp="f.lineHP"]
        [endif ]
    [endignore ]

[p]
;ゲームオーバー(クリア含む)の場合のみジャンプします。
;HPが0のとき、　あるいは　情報が4の時ジャンプします。
[jump target="*gameover" cond="f.hp==0||f.ifo==4"]



*none
;押しても意味がないボタン用の飛び先
[clearstack]

#あかね
セリフを繰り返すよ[p]
[jump target="*fight"]
;===　#ここからボタン選択待機画面=============================================┘
[s ]




*result
;どちらかの選択肢を押した結果
[clearstack]
[cm]

;ボタン連打で不具合がでるのでボタンを消しておく
[clearfix]

;押した状態で正解を変更して、正解したかどうかで分岐させます。
;f.ifo==2の状態で始まるので、あと2回回答する必要があります。
;正解はON,OFFの順です。(f.ans==0,1)
;成否によりf.isAnsが変化します。

;1回目2回目省略。
;3回目の答え合わせ
    [if exp="f.ifo==2&&f.ans==0"]
            ;正解の時の展開
            [eval exp="f.isAns=true"]

            #あかね
            な、なななんでわかったの！？『次の問題の答えは【OFF】だよ！』
        [elsif exp="f.ifo==2&&f.ans==1"]
            ;不正解の時の展開
            [eval exp="f.isAns=false"]

            #あかね
            正解は『ON』だから次はそれを選んでね！
    [endif]

;4回目の答え合わせ
    [if exp="f.ifo==3&&f.ans==1"]
            ;正解の時の展開
            [eval exp="f.isAns=true"]

            #あかね
            『まぁ、おもしろいゲームつくらないと、売れもしないけどなーーーー！！！！！』
        [elsif exp="f.ifo==3&&f.ans==0"]
            ;不正解の時の展開
            [eval exp="f.isAns=false"]
            #あかね
            正解は『OFF』だから次はそれを選んでね！

    [endif ]


    ;正解や不正解の処理
    ;正解の時…f.ifo(情報獲得数)の数値+1
    ;負正解の時…f.hp(相手の体力)の数値-1
    [if exp="f.isAns"]
        [eval exp="f.ifo=f.ifo+1"]
        [else ]
        [eval exp="f.hp=f.hp-1"]
    [endif ]

    ;なおJS文で書くとめっちゃ簡単に書けます。↓
    /*
        [iscript ]
            //獲得情報の数字が増えます。
            //JS文で同じ内容0
            if(f.isAns){
                f.ifo=f.ifo++;
            }else{
                f.hp=f.hp--;
            };

            //JS文で同じ内容1
            //if(f.isAns)f.ifo++;
            //if(!f.isAns)f.hp--;

            //JS文で同じ内容2
            //(f.isAns)?f.ifo++:f.hp--;
        [endscript ]
    */
[p]

;削除したボタンを元に戻します。
;一応消さなくてもなんとかなる工夫もできます。
;┗> targetを*noneのように押しても意味がない巨大透明画像で作ったボタンを使えば一応できます。スマートではないが！

    ;選択肢1(ONボタン)
    [button fix="true" name="btn0" graphic="config/c_skipon.png"           width="110" height="110" x="64"   y="35"        target="*result" exp="f.ans=0" ]
    ;選択肢2(OFFボタン)
    [button fix="true" name="btn1" graphic="config/button_unread_off.png"  width="110" height="110" x="174"  y="145"       target="*result" exp="f.ans=1" ]
    ;情報開示ゲージ(ボタンではないが、ボタンレイヤーに置く方がオススメ)
    [button fix="true" name="gue0" graphic="config/c_btn_back.png"         width="100" height="483" x="1116" y="36"        target="*none" ]


[jump target="*fight"]
[s ]

*gameover
/*
f.hp==0またはf.ifo==4のときたどり着きます。

f.hp==0の場合失敗演出、f.ifo==4のとき成功演出をします。

成功の時あかねちゃん
happy
失敗のときあかねちゃん
でない
*/

;あかねちゃん切り替え
[if exp="f.hp==0"]
    [chara_hide name="akane"]
    #
    あかねちゃんは帰ってしまいました。
[endif ]
[if exp="f.ifo==4"]
    [chara_mod name="akane" face="happy"]
    #
    ゲームクリア！
[endif ]
[p]

;ゲームが終わりました。エンディングでも流してください。

;もう一度遊ぶにしろタイトルに戻るにしろ変数を初期化します。
[clearvar]
;人物らも解放します。
[chara_hide name="akane" wait="false"]
[chara_hide name="yamato" wait="true"]
[free layer="0" name="akane"]
[free layer="1" name="yamato"]
;メッセージレイヤーも見えなくします。
[layopt layer="message0" visible="false"]

;手抜きするので、ダイアログを悪用して目立つ表示として使用します。
[dialog type="confirm" text="リトライ？" label_ok="する！" label_cancel="タイトルに戻る" target="*retry" storage_cancel="title.ks"]

[s ]