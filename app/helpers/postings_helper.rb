# encoding: utf-8

module PostingsHelper
  
  def yes_no
    [["Evet", true], ["Hayır", false]]
  end
  
  def turkish_day(day)
    tr_day = "Pzt" if day  == "Monday"
    tr_day = "Sali" if day == "Tuesday"
    tr_day = "Cars" if day == "Wednesday"
    tr_day = "Pers" if day == "Thursday"
    tr_day = "Cuma" if day == "Friday"
    tr_day = "Cmt" if day  == "Saturday"
    tr_day = "Pzr" if day  == "Sunday"
    return tr_day
  end
  

  def display_option_buttons(posting, respondable)
    content_tag("div", class: "span6 center") do
      if posting.controllable_by?(current_user)
        logger.info "controllable_by? #{posting.user.id} == #{current_user.id}"
        delete_posting_button
      else
        display_respondable_button respondable 
      end
    end
  end

  def display_respondable_button(respondable)
    if respondable
      link_to "#{t 'posting_helper.contact_owner'}", posting_contact_posting_owner_path(@posting.id), class: 'btn btn-primary btn-warning', id: 'respond-button', data: { toggle: 'modal', target: '#contact-posting-owner-modal-window' }, remote: true
    else
      link_to "#{t 'posting_helper.already_contacted_owner'}", '#', class: 'btn disabled', id: 'respond-button'
    end
  end

  def delete_posting_button
    link_to "#{t 'posting_helper.delete_posting'}", '#', method: :delete, confirm: "#{t 'posting_helper.confirmation'}", class: 'btn btn-primary btn-danger', id: 'respond-button'
  end

end
