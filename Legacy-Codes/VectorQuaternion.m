classdef VectorQuaternion
    properties
        t
        q
    end
            
    methods
        
        function r = VectorQuaternion(inT,inQ)
            if size(inT)== [3 1]
                r.t = inT;
            else 
                error('t has to be a 3*1 vector');  
            end
            
            try
                Quaternion(inQ);
            catch
                error('q has to be a unit Quaternion');  
            end
            
            if inQ.norm==1
                r.q= inQ;
            else
                error('q has to be a unit Quaternion');
            end
                
        end
        
        function r = poseCompose(inVQ1,inVQ2)
            if and(isQuaternion(inVQ1.q),isQuaternion(inVQ2.q))
               r = VectorQuaternion([0;0;0],UnitQuaternion);
               r.q=(inVQ1.q*inVQ2.q);
               q1 = inVQ1.q;
               r.t=(inVQ1.t+(q1.R)*inVQ2.t);
            else
               error('Only quaternion inputs are allowed');
            end
        end  
        
        function r = poseNegate(inVQ)
            
            if isQuaternion(inVQ.q)
               r = VectorQuaternion([0;0;0],UnitQuaternion);
               q0= inVQ.q;
               q_inv= q0.inv;
               t0= inVQ.t;
               r.t=-(q_inv.R)*t0;
               r.q=q_inv;
               
            else
               error('Only quaternion input is allowed');
            end
        end
        
        function r = VQtrans(inPt,inVQ)
            
            if and(isQuaternion(inVQ.q),size(inPt)== [3 1])
               q0= inVQ.q;
               t0= inVQ.t;
               r=-(q0.R)*inPt+t0; 
            else
                
               error('inputs must have the following form: desired point, quaternion');
            end
        end
    
    end
end