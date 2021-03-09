class RemoveBrokenReferenceFromPublishings < ActiveRecord::Migration[6.0]
    def change
      remove_reference :publishings, :channels, foreign_key: true
   end
end
