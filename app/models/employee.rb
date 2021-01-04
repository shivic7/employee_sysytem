class Employee < ApplicationRecord
	def self.search(search)
		if search
			emp = Employee.find_by(name: search)
			if emp
				self.where(id: emp)
			else
				Employee.all
			end
		else
			Employee.all
		end
	end
end
