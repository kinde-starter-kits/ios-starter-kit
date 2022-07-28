extension String {
    
    /// Navigation-safe access to a String character by 0-based index
    subscript(idx: Int) -> String? {
        return idx < self.count ? String(self[index(startIndex, offsetBy: idx)]) : nil
    }
}
