module QueryTracer
  module Db
    module Sqlite
      SKIP_QUERIES = [%r{FROM sqlite_master}]
      
      def execute_with_trace(sql)
        
      end
    end
  end
end