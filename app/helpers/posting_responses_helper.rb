module PostingResponsesHelper

  def responder_image(responder)
    link_to (image_tag responder.avatar.url(:thumb), size: 30), user_path(responder)
  end

  def responder_name(responder)
    link_to responder.name, user_path(responder), class:"responder-name"
  end

  def accept_response_button(response)
    link_to "<i class='icon-ok icon-white'></i><span style='color:white'>Gelsin</span>".html_safe, posting_response_enter_phone_path(response), class: 'btn btn-mini btn-success', data: { toggle: "modal", target: '#enter-phone-modal-window' }, method: :get, remote: true
  end

  def reject_response_button(response)
    link_to "<i class='icon-remove icon-white'></i><span style='color:white'>Gelmesin</span>".html_safe, posting_response_reject_path(response), class: 'btn btn-mini btn-danger', style:'margin-left:20px; margin-right:20px;', method: :get, remote: true
  end

  def answer_or_options(response)
    content_tag("span", id: "#{response.responder.name.parameterize}-answer", class: "posting-answers pull-right") do
      if response.accepted
        "#{t 'posting_responses_helper.accepted'}"            
      elsif response.rejected
        "#{t 'posting_responses_helper.not_accepted'}"            
      else
        "#{accept_response_button(response)} #{reject_response_button(response)}".html_safe
      end
    end
  end
end
