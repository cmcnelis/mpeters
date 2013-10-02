module ApplicationHelper

    def show_errors(model)
        render :partial=>'shared/errors', :locals=>{:model=>model}
    end
end
