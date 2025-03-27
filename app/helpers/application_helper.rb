module ApplicationHelper
  include NotificationsHelper

  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-green-500"
    when :alert  then "bg-red-500"
    when :error  then "bg-yellow-500"
    else "bg-gray-500"
    end
  end

  def default_meta_tags
    {
      site: "SuppleHub",
      title: "サプリメントを共有できるサービス",
      reverse: true,
      charset: "utf-8",
      description: "supplehubはサプリメントを共有できるサービスです。サプリメントの効果だけなく副作用も知ることができます。",
      keywords: "サプリメント,効果,副作用",
      canonical: "https://supplehub.onrender.com",
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: "https://supplehub.onrender.com/",
        image: image_url("ogp.png"),
        local: "ja_JP"
      },
      twitter: {
        card: "summary_large_image", # Twitterで表示する場合は大きいカードに変更
        site: "@",
        image: image_url("ogp.png")
      }
    }
  end
end
