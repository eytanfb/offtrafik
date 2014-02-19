class UserObserver < ActiveRecord::Observer
    def after_save(user)            
        if user.confirmed_at_changed?
            UserM
        end
    end
end