module QueryTracer
  module Db
    module Mysql
      SKIP_QUERIES = [%r{^(SET|SHOW)}]
      
      def execute_with_trace(sql)
        
      end
    end
  end
end