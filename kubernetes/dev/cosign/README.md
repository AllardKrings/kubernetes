#signing image with sbom

#generate sbom in spdx-format

syft quay.alldcs.nl/allard/olproperties:master  -o spdx > olproperties.spdx

#attach the sbom to the image:

cosign attach sbom --sbom olproperties.spdx quay.alldcs.nl/allard/olproperties:master

WARNING: Attaching SBOMs this way does not sign them. If you want to sign them, use '
cosign attest --predicate olproperties.spdx --key <key path>' or 'cosign sign --key <key path> --attachment sbom <image uri>'	

Uploading SBOM file for [quay.alldcs.nl/allard/olproperties:master] to [quay.alldcs.nl/allard/olproperties:sha256-4d79a08eb15ea8c9730e77fc54bea37299b4ed21d8b875d95fd54cd78e3556c9.sbom] with mediaType [text/spdx].

#singn the sbom:

cosing sign --key cosign.key quay.alldcs.nl/allard/olproperties:sha256-4d79a08eb15ea8c9730e77fc54bea37299b4ed21d8b875d95fd54cd78e3556c9.sbom

-	output:

Enter password for private key: 
WARNING: Image reference quay.alldcs.nl/allard/olproperties:sha256-4d79a08eb15ea8c9730e77fc54bea37299b4ed21d8b875d95fd54cd78e3556c9.sbom uses a tag, not a digest, to identify the image to sign.
    This can lead you to sign a different image than the intended one. Please use a
    digest (example.com/ubuntu@sha256:abc123...) rather than tag
    (example.com/ubuntu:latest) for the input to cosign. The ability to refer to
    images by tag will be removed in a future release.


        The sigstore service, hosted by sigstore a Series of LF Projects, LLC, is provided pursuant to the Hosted Project Tools Terms of Use, available at https://lfprojects.org/policies/hosted-project-tools-terms-of-use/.
        Note that if your submission includes personal data associated with this signed artifact, it will be part of an immutable record.
        This may include the email address associated with the account with which you authenticate your contractual Agreement.
        This information will be used for signing this artifact and will be stored in public transparency logs and cannot be removed later, and is subject to the Immutable Record notice at https://lfprojects.org/policies/hosted-project-tools-immutable-records/.

By typing 'y', you attest that (1) you are not submitting the personal data of any other person; and (2) you understand and agree to the statement and the Agreement terms at the URLs listed above.
Are you sure you would like to continue? [y/N] y
tlog entry created with index: 41682114
Pushing signature to: quay.alldcs.nl/allard/olproperties

#attest 
