ActiveSupport::Notifications.subscribe "process_action.action_controller" do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  status = event.payload[:status]
  if status.nil? && event.payload[:exception].present?
    exception_class_name = event.payload[:exception].first
    status = ActionDispatch::ExceptionWrapper.status_code_for_exception(exception_class_name)
  end

  visitor_hash = event.payload[:response] ? event.payload[:response][:visitor_hash] : nil
  user_id = event.payload[:response] ? event.payload[:response][:user_id] : nil

  RequestLog.create controller: event.payload[:controller],
                    action: event.payload[:action],
                    path: event.payload[:path],
                    status: status,
                    duration_ms: event.duration.round,
                    visitor_hash: visitor_hash,
                    user_id: user_id,
                    user_agent: event.payload[:request].user_agent,
                    ip: event.payload[:request].ip
end