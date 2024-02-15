local status_ok, mini_ai = pcall(require, 'mini.ai')
if not status_ok then
  return
end

mini_ai.setup()
