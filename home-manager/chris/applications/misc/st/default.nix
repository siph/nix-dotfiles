{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
        patches = [
          (fetchpatch {
            url = "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
            sha256 = "10gvwnpbjw49212k25pddji08f4flal0g9rkwpvkay56w8y81r22";
          })
          (fetchpatch {
            url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
            sha256 = "1ym5d2f85l3avgwf9q93aymdg23aidprqwyh9s1fdpjvyh80rvvq";
          })
          (fetchpatch {
            url = "https://st.suckless.org/patches/bold-is-not-bright/st-bold-is-not-bright-20190127-3be4cf1.diff";
            sha256 = "1cpap2jz80n90izhq5fdv2cvg29hj6bhhvjxk40zkskwmjn6k49j";
          })
          (fetchpatch {
            url = "https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.5.diff";
            sha256 = "0jvn0i0fl0w3c8dcmwyh9w19g3hsi22cqmyqly5zjzjwjhc8qnjv";
          })
        ];
      }))
  ];
}
