class SessionsController < ApplicationController
  def new
    # vazio, serve para o render new.html.erb automático
  end

  def create
    user = User.find_by(email: params[:session_form][:email].downcase)
    if user && user.authenticate(params[:session_form][:password])
      # se user != nill && pwd inserida estiver correcta
      log_in user # guardar user.id na sessão
      redirect_to user # redirect para user_url(user)
    else
      # cria uma mensagem (via flash) e faz render do form de novo
      flash.now[:danger] = 'Invalid email or password!'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
