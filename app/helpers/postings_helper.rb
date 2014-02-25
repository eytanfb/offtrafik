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
  
end
