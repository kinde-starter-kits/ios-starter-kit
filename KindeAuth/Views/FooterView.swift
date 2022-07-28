import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("KindeAuth").font(.body)
                Text("Visit our help center").font(.caption)
                Text("© 2022 KindeAuth, Inc. All rights reserved").font(.footnote).foregroundColor(Color.gray)
            }
            Spacer()
        }.padding(.top).frame(maxWidth: .infinity)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
