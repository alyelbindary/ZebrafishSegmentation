function MI = compute_MI(moving_image, fixed_image)

% Convert images to uint8 type
if class (moving_image) ~= "uint8"
    moving_image = uint8(moving_image./(max(moving_image(:))/255));
end

if class (fixed_image) ~= "uint8"
    fixed_image = uint8(fixed_image./(max(fixed_image(:))/255));
end

% Compute marginal entropy for X
moving_hist = histcounts(moving_image(:), 0:255);
moving_hist = moving_hist/sum(moving_hist);
H_x = -sum(moving_hist.*log2(moving_hist + eps)); % +eps to avoid log of zero

% Compute marginal entropy for Y
fixed_hist = histcounts(fixed_image(:), 0:255);
fixed_hist = fixed_hist / sum(fixed_hist);
H_y = -sum(fixed_hist.*log2(fixed_hist + eps));

% Compute joint entropy
joint_hist = histcounts2(moving_image(:), fixed_image(:), 0:255, 0:255);
joint_hist = joint_hist/sum(joint_hist(:));
H_xy = -sum(joint_hist(:).*log2(joint_hist(:) + eps));

MI = H_x + H_y - H_xy;

end

