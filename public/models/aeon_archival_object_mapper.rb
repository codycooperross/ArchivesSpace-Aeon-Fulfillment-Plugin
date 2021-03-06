class AeonArchivalObjectMapper < AeonRecordMapper

    register_for_record_type(ArchivalObject)

    def initialize(archival_object)
        super(archival_object)
    end

    # Override of #show_action? from AeonRecordMapper
    def show_action?
        return false if !super
        return self.requestable_based_on_archival_record_level?
    end

    # Override for AeonRecordMapper json_fields method.
    def json_fields
        mappings = super

        json = self.record.json
        if !json
            return mappings
        end

        if json['repository_processing_note'] && json['repository_processing_note'].present?
            mappings['repository_processing_note'] = json['repository_processing_note']
        end

        mappings
    end

    # Returns a hash that maps from Aeon OpenURL values to values in the provided record.
    def record_fields
        mappings = super

        mappings['component_id'] = self.record['component_id']

        mappings
    end
end
