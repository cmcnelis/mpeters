class AgentSessionsController < ApplicationController
   before_filter :require_no_user, :only => [:new, :create]
   before_filter :require_user, :only => :destroy

  def new
    @agent_session = AgentSession.new
  end

  def create
    @agent_session = AgentSession.new(params[:agent_session])
    if @agent_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_agent_sessions_path
  end

end
