function [ count ] = math4910_get_data()
%get_data for Dominican Republic
db = create_database();
count = db(1).count_linear;
end


