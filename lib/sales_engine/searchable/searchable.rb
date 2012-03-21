module SalesEngine
	module Searchable
		def all
			self.records
		end

		def random
			self.records.sample
		end

		def method_missing(method, *args, &block)
			command = method.to_s.split('_')
			if command[0..1] == ["find", "by"]
				field = command[2..-1].join('_')
				return find_by(field, *args) if self.records.first.respond_to?(field.to_sym)
			elsif command[0..2] == ["find", "all", "by"]
				field = command[3..-1].join('_')
				return find_all_by(field, *args) if self.records.first.respond_to?(field.to_sym)
			end
		  super(method, *args, &block)
		end

		def find_by(attribute, query)
			find_all_by(attribute, query).first
		end

		def find_all_by(attribute, query)
			all.select { |record| record.send(attribute.to_sym).downcase == query.downcase}
		end
	end
end
