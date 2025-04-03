class DiagnosesController < ApplicationController
  def new
    @assessment_result = session[:assessment_result]
    session[:assessment_result] = nil
  end

  def create
    # フォームから送信されたデータの取得
    health_condition = params[:health_condition]
    living_situation = params[:living_situation]
    sense_of_purpose = params[:sense_of_purpose]

    # OpenAI APIを使用して診断結果を取得
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    prompt = <<~PROMPT
      あなたは医療専門家です。以下の情報をもとに、患者の健康状態を評価し、300字以内で必要なサプリメントを提案してください。
      健康状態: #{health_condition}
      生活状況: #{living_situation}
      目的意識: #{sense_of_purpose}

    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: prompt } ],
        max_tokens: 500,
        temperature: 0.7
      }
    )
    @assessment_result = response.dig("choices", 0, "message", "content")

    if @assessment_result.present?
      session[:assessment_result] = @assessment_result
      flash[:notice] = "診断が成功しました。"
      redirect_to new_diagnosis_path
    else
      flash.now[:alert] = "診断に失敗しました。"
      render :new
    end
  end

  private

  def assessment_params
    params.permit(:health_condition, :living_situation, :sense_of_purpose)
  end
end
