%function v = isspherical(r)
        %SerialLink.isspherical Test for spherical wrist
        %
        % R.isspherical() is true if the robot has a spherical wrist, that is, the
        % last 3 axes are revolute and their axes intersect at a point.
        %
        % See also SerialLink.ikine6s.
            L = r.links(end-2:end);
            
            alpha = [-pi/2 pi/2];
            v =  all([L(1:2).a] == 0) && ...
                (L(2).d == 0) && ...
                (all([L(1:2).alpha] == alpha) || all([L(1:2).alpha] == -alpha)) && ...
                all([L(1:3).isrevolute]);
%        end