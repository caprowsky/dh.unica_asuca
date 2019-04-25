module TreeExt
  module ActsAsExternalSequence
    module ManageSequence

      # When a model acts_as_external_nodes, its sequence depends first of all on
      # the structure of the external tree it belongs to.
      # So the way to update the sequence in the current model, is finding the root
      # of its external tree, and then updating the external sequence
      # of the external root
      def rebuild_sequence_for_structural_root
        structural_root.rebuild_external_sequence if structural_root
      end

      def update_sequence_for_structural_root
        structural_root.update_full_external_sequence if structural_root
      end

      def insert_in_external_sequence
        if id.present? && total_external_nodes == 1
          initialize_root_external_sequence
        else
          update_sequence_in_new_external_node
        end
      end

      private

      def total_external_nodes
# Upgrade 2.0.0 inizio
#        self.class.count("id", :conditions => {self.class.external_parent_foreign_key.to_sym => structural_root.subtree_ids})
        self.class.where({self.class.external_parent_foreign_key.to_sym => structural_root.subtree_ids}).count("id")
# Upgrade 2.0.0 fine
      end

      def initialize_root_external_sequence
# Upgrade 2.0.0 inizio
#        self.class.update_all("sequence_number = 1", {:id => id}) if id.present?
        self.class.where({:id => id}).update_all("sequence_number = 1") if id.present?
# Upgrade 2.0.0 fine
      end

# Upgrade 2.0.0 inizio
=begin
      def update_sequence_in_new_external_node
        if id.present?
          self.class.update_all(
            "sequence_number = sequence_number+1",
            "sequence_number > #{last_sequence_number} AND fond_id IN (#{structural_root.subtree_ids.join(', ')})"
          )
          self.class.update_all("sequence_number = #{last_sequence_number + 1}", {:id => id})
        end
      end
=end
      def update_sequence_in_new_external_node
        if id.present?
          self.class.
          where("sequence_number > #{last_sequence_number} AND fond_id IN (#{structural_root.subtree_ids.join(', ')})").
          update_all("sequence_number = sequence_number+1")

          self.class.where({:id => id}).update_all("sequence_number = #{last_sequence_number + 1}")
        end
      end
# Upgrade 2.0.0 fine

    end
  end
end

