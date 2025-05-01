def is_sorted(nums):
    return all(nums[i] <= nums[i + 1] for i in range(len(nums) - 1))

def minimum_removals_to_almost_sorted(nums):
    n = len(nums)
    
    for i in range(n - 1):
        if nums[i] > nums[i + 1]:
            if is_sorted(nums[:i] + nums[i + 1:]):
                return 1
            if is_sorted(nums[:i + 1] + nums[i + 2:]):
                return 1
            return 2
    return 0

nums = list(map(int, input().strip().split()))
result = minimum_removals_to_almost_sorted(nums)
print(result)

