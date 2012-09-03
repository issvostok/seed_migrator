class FooUpdate
  def perform_update
    'perform foo update'
  end

  def undo_update
    'undo foo update'
  end
end