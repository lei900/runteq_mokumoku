# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def created_event
    @event = params[:event]
    @user = params[:user]
    mail(to: @user.email, subject: 'イベントが作成されました')
  end

  def commented_to_event
    @comment = params[:comment]
    @user = params[:user]
    mail(to: @user.email, subject: 'イベントにコメントがありました')
  end

  def attended_to_event
    @event_attendance = params[:event_attendance]
    @user = params[:user]
    mail(to: @user.email, subject: 'イベントへの参加申し込みがありました')
  end

  def liked_event
    @bookmark = params[:bookmark]
    @user = params[:user]
    mail(to: @user.email, subject: 'イベントがブックマークされました')
  end

  def following_attended_to_event
    @event_attendance = params[:event_attendance]
    @user = params[:user]
    mail(to: @user.email, subject: "#{@event_attendance.user.name}が参加するイベントがありました")
  end
end
