require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[0]

    left = array[1..-1].select { |x| x <= pivot }
    right = array[1..-1].select { |x| x > pivot }

    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new{ |el1, el2| el1 <=> el2}
    return array if length < 2

    pivot_idx = self.partition(array, start, length, &prc)

    self.sort2!(array, start, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, length - ((pivot_idx - start)+ 1), &prc)
  end



  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    i = start + 1

    pivot = array[start]
    b_idx = start
    while i < start + length
      if prc.call(array[i], pivot) < 0
        array[i], array[b_idx + 1] = array[b_idx + 1], array[i]
        b_idx += 1
      end
      i += 1
    end

    array[start], array[b_idx] = array[b_idx], array[start]

    b_idx
  end



end
