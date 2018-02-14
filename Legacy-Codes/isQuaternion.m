function logic = isQuaternion(inQ)
            try
                determine = Quaternion(inQ)
                logic = true();
            catch
                logic = false();
            end
        end