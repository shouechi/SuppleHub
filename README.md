# SuppleHub
<a href="https://gyazo.com/ced6d8da2cd4da2da89227d089b96bf2"><img src="https://i.gyazo.com/ced6d8da2cd4da2da89227d089b96bf2.jpg" alt="Image from Gyazo" width="800"/></a>
<br>アプリケーションURL:[SuppleHub](https://supplehub.jp)

## サービス概要
SuppleHubは、**実際に効果のあったサプリ・プロテインを共有するサービス**です。ユーザーが自身の体験を投稿したり、他のユーザーのレビューや情報を参考にして、信頼性の高いサプリ・プロテインを見つけることができます。

---

##　このサービスへの思い・作りたい理由
私自身、トレーニングを始めたばかりの頃や健康に気を使い始めた頃、さまざまなサプリやプロテインを試してきました。しかし、効果や選び方を調べるために、ネットで一つひとつ情報を探すのはとても大変でした。そんな経験から、実際に効果のあった情報や知識を簡単に共有できる場があれば便利だと感じたのが、このサービスを作りたいと思ったきっかけです。
さらに、初心者が「痩せる」「筋肉がつく」などの広告に惑わされ、不適切なサプリを購入してしまうケースが後を絶たない状況にも課題を感じました。このような被害を減らし、信頼できる情報を中立的に共有できるプラットフォームを提供することで、サプリやプロテインをより効果的かつ安全に活用できる環境を作りたいと考えています。

---

## ユーザー層について
- サプリ・プロテイン初心者
- 自分に合った製品を探している健康志向の人
- トレーニングに取り組む人

## サービスの利用イメージ
- サプリを探しているユーザー（例：マルチビタミンを探しているなど）が、SuppleHubでレビューを閲覧し、信頼できる製品を見つける。  
- 自分が効果を実感した製品を投稿し、共有する事ができる。  
- サプリの管理機能を活用し、使用量や購入時期を効率的に記録する。

## ユーザーの獲得について
想定したユーザー層に対してそれぞれどのようにサービスを届けるのか現状考えていることがあれば教えてください。
- サプリの説明などで、効果・副作用・おすすめ度など誰が見ても分かりやすいように分けて投稿できるようにする。
- サプリやプロテインを カテゴリ別（例: クレアチン、マルチビタミン、プロテイン、アミノ酸など） に分けて、検索を直感的にする。
- トレーニング仲間や私が加入している健康意識のコミュニティ内での発信をする。

## サービスの差別化ポイント
- **リアルな体験談の共有**  
  広告や販売目的に左右されない、実際に効果を感じた体験談や副作用の報告を投稿可能。
- **カテゴリ別検索**  
  クレアチン、マルチビタミン、プロテインなど、サプリ・プロテインの種類別に検索可能。
- **中立的なプラットフォーム**  
  広告や販売目的に影響されないため、健康志向やトレーニングを目的としたユーザー同士が信頼性の高い情報を交換できる。

※類似サービス（例：iHerb）との差別化として、広告要素を排除しユーザー目線での実体験を共有できる点が強みです。

---

## 機能一覧
| ログイン機能 |
|-|
| [![Image from Gyazo](https://i.gyazo.com/f212ec5dcd1c2c22f35712fc4d412637.gif)](https://gyazo.com/f212ec5dcd1c2c22f35712fc4d412637) | 
| Googleアカウントでログインできます。  |

| 新規登録機能 |
|-|
| [![Image from Gyazo](https://i.gyazo.com/9e7878f8ee6569f28ec81eb2ce2a0f39.gif)](https://gyazo.com/9e7878f8ee6569f28ec81eb2ce2a0f39) |
| 名前、メールアドレス、パスワードを入力して新規登録できます。<br>不備や入力漏れがあった場合はバリデーションでエラーが表示されます。  |

| 投稿機能 |
|-|
| [![Image from Gyazo](https://i.gyazo.com/77fbe596be04ec0ea378212b16761ff0.gif)](https://gyazo.com/77fbe596be04ec0ea378212b16761ff0) |
| サプリ名・効果・副作用・画像を入力して投稿できます。<br>投稿後は編集・削除が可能です。<br>不備や入力漏れがあった場合はバリデーションでエラーが表示されます。 |

| 診断機能 |
|-|
| [![Image from Gyazo](https://i.gyazo.com/85ae214034337392030b94042da6a522.gif)](https://gyazo.com/85ae214034337392030b94042da6a522) |
| 健康状態・生活状況・目的意識を入力し、診断結果を確認できます。 |

| コメント機能 |
|-|
| [![Image from Gyazo](https://i.gyazo.com/09e8ad612432968de16597dc45ae365a.gif)](https://gyazo.com/09e8ad612432968de16597dc45ae365a) |
| 各投稿にコメントでき、ActionCableを使ってリアルタイムで反映されます。 |

| 詳細機能 |
|-|
| <a href="https://gyazo.com/773e702ea3b489db1259b1bedb47a19e"><img src="https://i.gyazo.com/773e702ea3b489db1259b1bedb47a19e.jpg" alt="Image from Gyazo" width="600"/></a> |
| 各投稿の詳細を閲覧できます。<br>X（旧Twitter）での共有、編集、削除が可能です。  |

---

### 使用技術

| カテゴリ | 技術 |
| --- | --- | 
| フロントエンド | Ruby on Rails 7.2.2 / JavaScript / Stimulus |
| バックエンド | Ruby 3.2.3 / Ruby on Rails 7.2.2 |
| CSSフレームワーク | tailwindcss / daisyUI |
| データベース | PostgreSQL |
| 認証 | Devise / Omniauth（Google OAuth対応） |
| Web API | Google API / Openai API|
| 環境構築 | Docker |
| インフラ | Render.com / Redis / Amazon S3 |
| バージョン管理ツール | GitHub |
<br>



---

### 画面遷移図
Figma：https://www.figma.com/design/YfjhckMAA4QOLQYUShXbXG/SuppleHub-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&node-type=canvas&t=uYsBbisERXiNej5u-0
[![Image from Gyazo](https://i.gyazo.com/65997661e6a3493234126fe4a5884533.png)](https://gyazo.com/65997661e6a3493234126fe4a5884533)

---

### ER図
ER図 : https://dbdiagram.io/d/SupppleHub-675acad546c15ed4792a37b0
[![Image from Gyazo](https://i.gyazo.com/00cb86a404bef5e40eaed7354ae878a4.png)](https://gyazo.com/00cb86a404bef5e40eaed7354ae878a4)